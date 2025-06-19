# Native Android Webchat Webview Integration
> 📝 **Note**: Tested and developed with the latest Android Jetpack version 🎯 .

1. #### Start with a clean Kotlin/Java/Groovy project

2. #### Create a function named **WebViewScreen**

    ```kotlin
    @SuppressLint("SetJavaScriptEnabled")
    @Composable
    fun WebViewScreen(isVisible: MutableState<Boolean>) {
        val context = LocalContext. current
        val webView = WebView(context)
        webView. clearCache ( includeDiskFiles: true)
        webView.clearHistory()

        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.allowFileAccess = true
        webView.settings.cacheMode = WebSettings.LOAD_DEFAULT
        webView. webChromeClient = CustomWebViewClient()

        webView.addJavascriptInterface(WebAppInterface(context, isVisible),name: "Android")

        webView.loadUrl( url: "https://demo-app.sestek.com/gbk mobile.html")

        AndroidView(
            modifier = Modifier.fillMaxSize(),
            factory = { webView}
        )
    }
    ```

1. #### Allow few features like localstorage, js usage.

    ```kotlin
    class CustomWebViewClient : WebChromeClient() {
        override fun onPermissionRequest(request: PermissionRequest?) {
            request?.grant(request.resources)
        }
    ｝
    ```



2. #### Use this section to capture and customise events. **Required** for capturing shutdown event


    ```kotlin
    class WebAppInterface(private val mContext: Context,isVisible: MutableState<Boolean>) {

        var mvisible : MutableState<Boolean>?=null;

        init {
            myVisible = isVisible;
        }

        @JavascriptInterface
        fun getCloseChatEvent(toast: String) {
            myVisible?.value = false
        }
    }
    ```


3. #### Call the composable `WebViewScreen`` function created


    ```kotlin
    class MainActivity : ComponentActivity {
        override fun onCreate(savedInstanceState: Bundle?) {

            super.onCreate(savedInstanceState)

            setContent {
                WebviewWebchatTheme {
                    Surface (
                        modifier = Modifier.fillMaxSize(),
                        color = MaterialTheme.colorScheme.background
                    ){
                        NavigationView()
                    }
                }
            }
        }
    }
    ```


4.  #### Grant permissions in AndroidManifest.xml,  ie. *internet access*


    - `android.permission.INTERNET`
    - `android.permission.RECORD_AUDIO`
    - `android.permission.MODIFY_AUDIO_SETTINGS`
    - `android.permission.WRITE_EXTERNAL_STORAGE`
    - `android.permission.READ_EXTERNAL_STORAGE`
    - `android.permission.CHANGE_WIFI_MULTICAST_STATE`
    - `android.permission.ACCESS_WIFI_STATE`
    - `android.permission.CHANGE_WIFI_STATE`
    - `android.permission.ACCESS_COARSE_LOCATION`
    - `android.permission.CHANGE_NETWORK_STATE`
    - `android.permission.ACCESS_NETWORK_STATE`


7. #### Implement packages in your build.gralde file

    - `androidx.navigation:navigation-compose:2.5.3`
    - `androidx.compose.material3:material3:1.2.0-alpha02`
    - `com.google.accompanist:accompanist-permissions:0.29.0-alpha`


8. #### Show the `Webview` with a `buttonModalSheet`. Configure as per your project requirement


    <img width="750" alt="MicrosoftTeams-image (17)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/e84fe9d8-beaf-477e-b69b-721302f2285b">


9. #### Have fun while developing ✨ 🎉

## Sample Screenshots:
<img width="750" alt="MicrosoftTeams-image (10)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/33286826-3298-4895-ae5e-be751aa44abd">

<img width="750" alt="MicrosoftTeams-image (11)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/0f3ba0ba-8004-4913-81f1-540e08179f5d">

<img width="750" alt="MicrosoftTeams-image (12)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/df0557fa-d55e-4c16-b50e-3e3ffb00a863">



