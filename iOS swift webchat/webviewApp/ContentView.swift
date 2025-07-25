import SwiftUI
import WebKit

final class SwiftUIWebViewModel: NSObject, ObservableObject, WKScriptMessageHandler {
    @Published var isWebViewOpen = false
    var webView: WKWebView!

    override init() {
        super.init()

        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        self.webView = WKWebView(frame: .zero, configuration: config)
    }

    func loadUrl() {
        guard let url = URL(string: "https://demo-app.sestek.com/webviewapp/mobile.html") else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        webView.load(request)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("📩 Message from JS: \(message.body)")

        if let dictionary = message.body as? [String: Any],
           let event = dictionary["event"] as? String,
           event == "closeChat" {
            print("✅ closeChat event received. Closing WebView.")

            self.isWebViewOpen = false

            DispatchQueue.main.async {
                
                print("✅ closeChat event received. Closing WebView.")
                self.isWebViewOpen = false
            }
        }
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    @Binding var isWebViewOpen: Bool
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView: View {
    @StateObject private var model = SwiftUIWebViewModel()

    var body: some View {
        VStack {
            if model.isWebViewOpen {
                SwiftUIWebView(isWebViewOpen: $model.isWebViewOpen, webView: model.webView)
                    .onAppear {
                        model.loadUrl()
                    }
            } else {
                Button("Open Sestek WebChat") {
                    model.isWebViewOpen = true
                }
            }
        }
    }
}

