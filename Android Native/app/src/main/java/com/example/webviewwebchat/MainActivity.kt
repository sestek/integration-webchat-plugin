package com.example.webviewwebchat

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.webkit.JavascriptInterface
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.viewinterop.AndroidView
import com.example.webviewwebchat.ui.theme.WebviewWebchatTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            WebviewWebchatTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    WebViewScreen()
                }
            }
        }
    }
}


@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    WebviewWebchatTheme {
        Greeting("Android")
    }
}

class WebAppInterface(private val mContext: Context) {
    // In this section, you can write a function as you want as soon as the webchat is closed.
    @JavascriptInterface
    fun showToast(toast: String) {
        Toast.makeText(mContext, toast, Toast.LENGTH_SHORT).show()
    }
}

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

    webView.addJavascriptInterface(WebAppInterface(context), "Android")

    webView.loadUrl("https://demo-app.sestek.com/mobile_test.html")

    AndroidView(
        modifier = Modifier.fillMaxSize(),
        factory = { webView }
    )
}
