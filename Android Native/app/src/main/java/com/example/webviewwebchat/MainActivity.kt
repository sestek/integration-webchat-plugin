package com.example.webviewwebchat

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.net.http.SslError
import android.os.Bundle
import android.webkit.JavascriptInterface
import android.webkit.PermissionRequest
import android.webkit.SslErrorHandler
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.*
import androidx.compose.material3.BottomSheetDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.webviewwebchat.ui.theme.WebviewWebchatTheme
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.rememberMultiplePermissionsState


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            WebviewWebchatTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    NavigationView()
                }
            }
        }
    }
}

@OptIn(ExperimentalPermissionsApi::class, ExperimentalMaterial3Api::class)
@Composable
fun NavigationView() {
    val navController = rememberNavController();
    val isWebViewVisible = remember { mutableStateOf(false) }


    var permissions = listOf(
        Manifest.permission.RECORD_AUDIO,
    )

    val permissionsState = rememberMultiplePermissionsState(
        permissions = permissions,
    )

    NavHost(navController = navController, startDestination = "home") {

        composable("home") {
            if(isWebViewVisible.value){
                BottomSheet(isWebViewVisible)
            }
            else{
                Column(
                    modifier = Modifier.fillMaxSize(),
                    verticalArrangement = Arrangement.Center,
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = "Sestek",
                        modifier = Modifier.padding(16.dp)
                    )
                    Button(onClick = { isWebViewVisible.value = true }) {
                        Text(text = "Open WebView")
                    }

                    if(permissionsState.allPermissionsGranted){
                        // permission OK
                    }else{
                        // permission NO
                        Button(
                            onClick = {
                                permissionsState.launchMultiplePermissionRequest()
                            }
                        ) {
                            Text(text = "Request permissions")
                        }
                    }

                }

            }
        }
    }
}

class CustomWebViewClient : WebChromeClient() {
    override fun onPermissionRequest(request: PermissionRequest?) {
        request?.grant(request.resources)
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Sestek",
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

class WebAppInterface(private val mContext: Context,isVisible: MutableState<Boolean>) {
    var myVisible : MutableState<Boolean>?=null;
    init {
        myVisible = isVisible;
    }
    @JavascriptInterface
    fun getCloseChatEvent(toast: String) {
        myVisible?.value = false
    }
}


@SuppressLint("SuspiciousIndentation")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BottomSheet(isVisible: MutableState<Boolean>) {
    val modalBottomSheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
        ModalBottomSheet(
            onDismissRequest = { isVisible.value = false },
            sheetState = modalBottomSheetState,
            dragHandle = { BottomSheetDefaults.DragHandle() },
            modifier = Modifier.fillMaxSize()

        ) {
            WebViewScreen(isVisible)
        }
}

@SuppressLint("SetJavaScriptEnabled")
@Composable
fun WebViewScreen(isVisible: MutableState<Boolean>) {
    val context = LocalContext.current
    val webView = WebView(context)
    webView.clearCache(true)
    webView.clearHistory()

    webView.settings.javaScriptEnabled = true
    webView.settings.domStorageEnabled = true
    webView.settings.allowFileAccess = true
    webView.settings.cacheMode = WebSettings.LOAD_DEFAULT
    webView.webChromeClient = CustomWebViewClient()


    webView.addJavascriptInterface(WebAppInterface(context,isVisible), "Android")


    webView.loadUrl("https://demo-app.sestek.com/gbk_mobile.html")


    AndroidView(
        modifier = Modifier.fillMaxSize(),
        factory = { webView }
    )
}







