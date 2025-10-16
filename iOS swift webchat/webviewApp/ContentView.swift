import SwiftUI
import WebKit

enum ChatState { case closed, hidden, visible }

@inline(__always)
private func onMain(_ block: @escaping () -> Void) {
    if Thread.isMainThread { block() } else { DispatchQueue.main.async(execute: block) }
}

final class ScriptBridge: NSObject, WKScriptMessageHandler {
    weak var owner: SwiftUIWebViewModel?

    init(owner: SwiftUIWebViewModel) { self.owner = owner }

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: Any],
              let event = dict["event"] as? String else { return }

        onMain {
            guard let vm = self.owner, !vm.isShuttingDown else { return }
            switch event {
            case "hideChat":
                if vm.shouldIgnoreHideEvent() { return }
                vm.hide()
            case "closeChat":
                vm.close()
            default:
                break
            }
        }
    }
}

final class SwiftUIWebViewModel: NSObject, ObservableObject, WKNavigationDelegate, WKUIDelegate {
    @Published var state: ChatState = .closed

    private(set) var webView: WKWebView?
    private var bridge: ScriptBridge?
    private let handlerName = "callbackHandler"

    private let startURL = URL(string: "https://demo-app.sestek.com/webviewapp/mobile.html")!

    private var ignoreHideUntil: Date?
    fileprivate var isShuttingDown = false

    func shouldIgnoreHideEvent() -> Bool {
        if let until = ignoreHideUntil, Date() < until { return true }
        return false
    }

    func open() {
        onMain {
            self.ensureWebView()
            self.loadIfNeeded()
            self.state = .visible
            self.armHideGuard(1.2)
        }
    }

    func hide() {
        onMain {
            guard self.webView != nil else { return }
            self.state = .hidden
        }
    }

    func close() {
        onMain {
            self.state = .closed
            self.tearDownWebView()
        }
    }

    private func armHideGuard(_ seconds: TimeInterval) {
        ignoreHideUntil = Date().addingTimeInterval(seconds)
    }

    private func ensureWebView() {
        guard webView == nil else { return }

        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        contentController.removeScriptMessageHandler(forName: handlerName)

        let bridge = ScriptBridge(owner: self)
        contentController.add(bridge, name: handlerName)
        self.bridge = bridge
        config.userContentController = contentController

        let wv = WKWebView(frame: .zero, configuration: config)
        wv.isOpaque = false
        wv.backgroundColor = .clear

        // 👇 ÖNEMLİ: delegeler
        wv.navigationDelegate = self
        wv.uiDelegate = self

        self.webView = wv
    }

    private func loadIfNeeded() {
        guard let webView = webView, webView.url == nil else { return }
        let req = URLRequest(url: startURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        webView.load(req)
    }

    private func tearDownWebView() {
        guard let wv = webView else { return }
        isShuttingDown = true

        bridge?.owner = nil
        wv.stopLoading()
        wv.navigationDelegate = nil
        wv.uiDelegate = nil

        bridge = nil
        webView = nil
        ignoreHideUntil = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.isShuttingDown = false
        }
    }

    // MARK: - Dış Link Açma
    private func openExternal(_ url: URL) {
        if ["http", "https", "mailto", "tel", "sms", "whatsapp"].contains(url.scheme?.lowercased() ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unsupported scheme: \(url)")
        }
    }

    // 👇 Linke tıklama durumunu yakala
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.allow); return
        }

        let isInitialLoad = (webView.url == nil && url == startURL)
        let isUserTap = navigationAction.navigationType == .linkActivated
        let isTargetBlank = navigationAction.targetFrame == nil

        if !isInitialLoad && (isUserTap || isTargetBlank) {
            openExternal(url)
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }

    // 👇 target="_blank" gibi yeni pencere durumları
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {

        if let url = navigationAction.request.url {
            openExternal(url)
        }
        return nil
    }
}

struct WebViewHost: UIViewRepresentable {
    let webView: WKWebView
    let visible: Bool

    func makeUIView(context: Context) -> WKWebView { webView }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.isHidden = !visible
        uiView.isUserInteractionEnabled = visible
    }
}

struct ContentView: View {
    @StateObject private var model = SwiftUIWebViewModel()

    var body: some View {
        ZStack {
            if let wv = model.webView {
                WebViewHost(webView: wv, visible: model.state == .visible)
                    .ignoresSafeArea()
            }

            if model.state != .visible {
                VStack {
                    Spacer()
                    Button("Open Sestek WebChat") {
                        model.open()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

