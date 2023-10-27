//
//  ContentView.swift
//  webviewApp
//
//  Created by Tayfun Kaya  on 13.10.2023.
//

import SwiftUI
import WebKit


final class SwiftUIWebViewModel: NSObject, ObservableObject, WKScriptMessageHandler {
    @Published var urlString = "https://demo-app.sestek.com/gbk_mobile.html"
    @Published var isWebViewOpen = false
    let webView: WKWebView
    override init() {
        webView = WKWebView(frame: .zero)
        super.init()
        webView.configuration.userContentController.add(self, name: "callbackHandler")
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    // get event: closed chat and minimize chat
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let dictionary = message.body as? [String: Any], let closed = dictionary["closed"] as? Int {
                if closed == 1 {
                    isWebViewOpen = false
                }
        }
    }
}


struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    @Binding var isWebViewOpen: Bool
    let webView: WKWebView
    func makeUIView(context: Context) -> WKWebView {webView}
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}


struct ContentView: View {
    @StateObject private var model = SwiftUIWebViewModel()
    var body: some View {
        VStack {
            if(model.isWebViewOpen){
                NavigationStack {
                    SwiftUIWebView(isWebViewOpen: $model.isWebViewOpen, webView: model.webView)
                                .onAppear {
                                    model.loadUrl()
                                    model.isWebViewOpen = true
                                    
                                }
                }
            }
            else{
                Button("Open Sestek WebChat") {
                    model.isWebViewOpen = true
                }
            }
           
        }
    }
}

#Preview {
    ContentView()
}
