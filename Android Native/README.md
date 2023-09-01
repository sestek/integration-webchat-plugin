# INTEGRATION Webchat webview in Android Native:

● First, let's start a clean Kotlin/Java/Groovy project

● We have to create function named WebViewScreen

![Screenshot 2023-09-01 at 12 04 33](https://github.com/sestek/integration-webchat-plugin/assets/54579230/096769be-9e2b-4c59-80fd-a9419164954f)

```javascript
@SuppressLint("SetJavaScriptEnabled")
@Composable
fun WebViewScreen() {
    val context = LocalContext.current
    val webView = WebView(context)
    webView.clearCache(true)
    webView.clearHistory()
    webView.settings.javaScriptEnabled = true
    webView.settings.domStorageEnabled = true
    webView.webViewClient = WebViewClient()
    webView.settings.cacheMode = WebSettings.LOAD_DEFAULT

    // We are capturing the webchat shutdown event from webview, the event name is Android
    webView.addJavascriptInterface(WebAppInterface(context), "Android")

    webView.loadUrl("https://demo-app.sestek.com/mobile_test.html")

    AndroidView(
        modifier = Modifier.fillMaxSize(),
        factory = { webView }
    )
}
```
Here we allow few features like localstorage, js usage.

Required for capturing shutdown event

![Screenshot 2023-09-01 at 12 25 55](https://github.com/sestek/integration-webchat-plugin/assets/54579230/174635ac-79d8-4823-8ed6-a5c93fc7f84a)

● We naturally call the composable WebViewScreen function we created

![Screenshot 2023-09-01 at 12 06 09](https://github.com/sestek/integration-webchat-plugin/assets/54579230/f9c86b7c-0c4c-4f70-835b-95213b631643)

● We need to grant some permissions in AndroidManifest.xml. Such as internet access etc.
```javascript
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```
● After opening the webview and closing the chat, routing and using is entirely up to your skills. Develop with fun ✨ 🎉

![Screenshot 2023-09-01 at 12 04 46](https://github.com/sestek/integration-webchat-plugin/assets/54579230/0b149556-b3cb-46f6-aca4-f462e53501b6)

● It has been tested and developed with current android versions 🎯 .

