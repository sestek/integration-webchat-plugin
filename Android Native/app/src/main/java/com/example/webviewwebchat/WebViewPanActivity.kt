package com.example.webviewwebchat

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
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
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.imePadding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.content.ContextCompat

class WebViewPanActivity : ComponentActivity() {

    private var pendingPermissionRequest: PermissionRequest? = null

    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { isGranted: Boolean ->
        if (isGranted) {
            pendingPermissionRequest?.grant(pendingPermissionRequest?.resources)
        } else {
            pendingPermissionRequest?.deny()
        }
        pendingPermissionRequest = null
    }

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
                webView.settings.javaScriptCanOpenWindowsAutomatically = true
                webView.settings.setSupportMultipleWindows(true)

                webView.webViewClient = WebViewClient()
                webView.webChromeClient = object : WebChromeClient() {
                    override fun onPermissionRequest(request: PermissionRequest?) {
                        request?.let {
                            // Mikrofon izni gerekiyorsa
                            if (it.resources.contains(PermissionRequest.RESOURCE_AUDIO_CAPTURE)) {
                                // Android runtime izinlerini kontrol et
                                if (ContextCompat.checkSelfPermission(
                                        this@WebViewPanActivity,
                                        Manifest.permission.RECORD_AUDIO
                                    ) == PackageManager.PERMISSION_GRANTED
                                ) {
                                    // İzin zaten verilmiş
                                    it.grant(it.resources)
                                } else {
                                    // İzin iste
                                    pendingPermissionRequest = it
                                    requestPermissionLauncher.launch(Manifest.permission.RECORD_AUDIO)
                                }
                            } else {
                                // Diğer izinler için direkt ver
                                it.grant(it.resources)
                            }
                        }
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
