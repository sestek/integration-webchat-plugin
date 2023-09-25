import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key});

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var statusWeb = false;
  Future<void> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (status.isGranted) {
      statusWeb = true;
    } else {}
  }

  var loadingPercentage = 0;
  @override
  Widget build(BuildContext context) {
    InAppWebViewController _webViewController;
    return Expanded(
      child: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.https('demo-app.sestek.com', '/gbk_mobile.html')),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
