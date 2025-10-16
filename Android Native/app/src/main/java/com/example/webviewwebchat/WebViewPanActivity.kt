package com.example.webviewwebchat

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.WindowManager
import android.webkit.JavascriptInterface
import android.webkit.PermissionRequest
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.OnBackPressedCallback
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.imePadding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.viewinterop.AndroidView

class WebViewPanActivity : ComponentActivity() {

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)

        setContent {
            WebViewScreen(url = "https://demo-app.sestek.com/webviewapp/mobile.html")
        }
    }

    inner class Bridge {
        @JavascriptInterface
        fun getCloseChatEvent(msg: String?) {
            runOnUiThread { finish() } // web'den çağrıldığında aktiviteyi kapat
        }

        @JavascriptInterface
        fun closeChat() {
            runOnUiThread { finish() }
        }
    }

    @Composable
    @SuppressLint("SetJavaScriptEnabled")
    fun WebViewScreen(url: String) {
        AndroidView(
            modifier = Modifier
                .fillMaxSize()
                .imePadding(),
            factory = { ctx ->
                val webView = WebView(ctx)
                webView.settings.javaScriptEnabled = true
                webView.settings.domStorageEnabled = true
                webView.settings.mediaPlaybackRequiresUserGesture = false

                webView.webViewClient = WebViewClient()
                webView.webChromeClient = object : WebChromeClient() {
                    override fun onPermissionRequest(request: PermissionRequest?) {
                        request?.grant(request.resources)
                    }
                }

                // JS Bridge
                webView.addJavascriptInterface(Bridge(), "Android")

                onBackPressedDispatcher.addCallback(
                    this@WebViewPanActivity,
                    object : OnBackPressedCallback(true) {
                        override fun handleOnBackPressed() {
                            if (webView.canGoBack()) webView.goBack()
                            else finish()
                        }
                    }
                )

                webView.loadUrl(url)
                webView
            }
        )
    }
}
