//
//  ContentView.swift
//  webviewApp
//
//  Created by Tayfun  on 13.10.2023.
//
/*
 //
 //  ContentView.swift
 //  webviewApp
 //
 //  Created by Tayfun  on 13.10.2023.
 //

 import SwiftUI
 import WebKit




 class MyViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
     
     private var webView: WKWebView!
     @Published var urlString = "https://demo-app.sestek.com/mobile.html"

     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Kullanıcı içerik denetleyicisi oluştur
         let contentController = WKUserContentController()
         
         // Kullanıcı mesaj işleyicisi ekle
         contentController.add(
             self,
             name: "callbackHandler"
         )
         
         // Web görünümü yapılandırması oluştur
         let config = WKWebViewConfiguration()
         config.userContentController = contentController
         
         // Web görünümü oluştur
         webView = WKWebView(frame: view.bounds, configuration: config)
         webView.navigationDelegate = self

         
         // Web sayfasını yükle
        loadUrl()
     }
     
     // JavaScript'ten gelen mesajları işleyen metod
     func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
         // JavaScript'ten gelen mesajı yazdır
         print(message.body)
     }
     
     func loadUrl() {
         guard let url = URL(string: urlString) else {
             return
         }
         webView.load(URLRequest(url: url))
     }
     
     // Web sayfasının yüklendiğini bildiren metod
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         // Web sayfası yüklendikten sonra, JavaScript'ten gelen mesajları işleyen fonksiyonu çağır
         webView.evaluateJavaScript("sendEvent('Merhaba, Swift!')")
     }
 }

 struct MyViewControllerRepresentable: UIViewControllerRepresentable {
     func makeUIViewController(context: Context) -> MyViewController {
         return MyViewController()
     }

     func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
         // Herhangi bir güncelleme işlemi gerekiyorsa burada yapılabilir.
     }
 }



 final class SwiftUIWebViewModel: ObservableObject {
     
     @Published var urlString = "https://demo-app.sestek.com/mobile.html"
     
     
     let webView: WKWebView
     init() {
         webView = WKWebView(frame: .zero)
     }
  
     
     func loadUrl() {
         guard let url = URL(string: urlString) else {
             return
         }
         webView.load(URLRequest(url: url))
     }
   
 }



 struct SwiftUIWebView: UIViewRepresentable {
     typealias UIViewType = WKWebView
     
     let webView: WKWebView
     
     func makeUIView(context: Context) -> WKWebView {
         webView
     }
     func updateUIView(_ uiView: WKWebView, context: Context) {
     }
 }



 struct ContentView: View {
     @State private var isPresentWebView = false
     @StateObject private var model = SwiftUIWebViewModel()
     
     var body: some View {
         VStack {
             Button("Open WebView") {
                         // 2
                         isPresentWebView = true

                     }
             .sheet(isPresented: $isPresentWebView) {
                 /*
                         NavigationStack {
                             // 3
                             SwiftUIWebView(webView: model.webView)
                                         .onAppear {
                                             model.loadUrl()
                                             print("selam1")
                                             
                                         }
                         }
                  */
                         MyViewControllerRepresentable()
                     }
            
         }
     }
 }

 #Preview {
     MyViewController()
 }


*/
