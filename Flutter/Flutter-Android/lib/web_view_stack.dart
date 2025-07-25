
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() async {
//     await _preparePermissions();         

//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const WebViewStack());
// }

// Future<void> _preparePermissions() async {
//   await [
//     Permission.microphone,
//   ].request();
//   await [
//     Permission.camera,
//   ].request();
// }

// class WebViewStack extends StatelessWidget {
//   const WebViewStack({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner:false,
//        home: const InAppWebViewPage(), 
//     );
//   }
// }

// class InAppWebViewPage extends StatefulWidget {
//   const InAppWebViewPage({super.key});

//   @override
//   State<InAppWebViewPage> createState() => _InAppWebViewPageState();
// }

// class _InAppWebViewPageState extends State<InAppWebViewPage> {
//   late final InAppWebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//          initialFile: 'assets/index.html', 
//         //   initialUrlRequest: URLRequest(
//         //   url: WebUri("https://demo-app.sestek.com/iframeloader/sestekloader.html"),
//         // ),
//         initialSettings: InAppWebViewSettings(
//            javascriptMode: JavascriptMode.unrestricted,

//           // javaScriptEnabled: true,
//           javaScriptCanOpenWindowsAutomatically: true,
//           supportMultipleWindows: true,            
//           mediaPlaybackRequiresUserGesture: false, // autoplay
//           allowsInlineMediaPlayback: true,         // iOS inline video
//           useHybridComposition: true,              // Android
//           allowFileAccess: true,
//           allowFileAccessFromFileURLs: true,
//           allowUniversalAccessFromFileURLs: true,
//            domStorageEnabled: true,              // Web Storage API (localStorage vs)
//   databaseEnabled: true,                // HTML5 Web SQL (bazı durumlarda gerekli)
//   cacheEnabled: true,    
//         ),
        
//         onWebViewCreated: (controller) {
//           _controller = controller;

//           // register handler named "onClose"
//           controller.addJavaScriptHandler(
//             handlerName: 'onClose',
//             callback: (args) {
//               // Flutter host: navigate back or to home
//               Navigator.of(context).pop(); 
//               return;
//             },
//           );
//         },

//         onCreateWindow:
//             (controller, createWindowRequest) async {
//           await controller.loadUrl(
//             urlRequest: createWindowRequest.request,
//           );
//           return false;                            
//         },

//         androidOnPermissionRequest:
//             (controller, origin, resources) async {
//           return PermissionRequestResponse(
//             resources: resources,
//             action: PermissionRequestResponseAction.GRANT,
//           );
//         },
//       ),
//     );
//   }
// }

 


// import 'package:flutter/material.dart';

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:permission_handler/permission_handler.dart';

// void main() async {

//   WidgetsFlutterBinding.ensureInitialized();

//   await _preparePermissions();         

//   runApp(const WebViewStack());

// }

// Future<void> _preparePermissions() async {

//   await [

//     Permission.microphone,

//     Permission.camera,

//   ].request();

// }

// class WebViewStack extends StatelessWidget {

//   const WebViewStack({super.key});

//   @override

//   Widget build(BuildContext context) {

//     return const MaterialApp(

//       debugShowCheckedModeBanner: false,

//       home: InAppWebViewPage(),

//     );

//   }

// }

// class InAppWebViewPage extends StatefulWidget {

//   const InAppWebViewPage({super.key});

//   @override

//   State<InAppWebViewPage> createState() => _InAppWebViewPageState();

// }

// class _InAppWebViewPageState extends State<InAppWebViewPage> {

//   InAppWebViewController? _controller;
 
//   @override

//   Widget build(BuildContext context) {

//     return Scaffold(

//       body: InAppWebView(

//         initialUrlRequest: URLRequest(

//           url: WebUri("https://demo-app.sestek.com/iframeloader/sestekloader.html"),

//         ),

//         initialSettings: InAppWebViewSettings(

//           javaScriptEnabled: true,

//           mediaPlaybackRequiresUserGesture: false,

//           allowsInlineMediaPlayback: true,

//           useHybridComposition: true,
//           // mediaCapturePermissionGrantType: MediaCapturePermissionGrantType.PROMPT, // <-- Bunu ekle


//         ),

//         onWebViewCreated: (controller) {

//           _controller = controller;
 
//           controller.addJavaScriptHandler(

//             handlerName: 'onClose',

//             callback: (args) {

//               Navigator.of(context).pop();

//             },

//           );

//         },

//         onConsoleMessage: (controller, consoleMessage) {

//           print("JS says: ${consoleMessage.message}");

//         },

//         androidOnPermissionRequest: (controller, origin, resources) async {

//           return PermissionRequestResponse(

//             resources: resources,

//             action: PermissionRequestResponseAction.GRANT,

//           );

//         },

//         onCreateWindow: (controller, createWindowRequest) async {

//           await controller.loadUrl(urlRequest: createWindowRequest.request);

//           return false;

//         },

//       ),

//     );

//   }

// }
 


import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
//   bool permissionsGranted = await _checkPermissions();
// print("Merhaba, bu bir log mesajıdır");
//   if (permissionsGranted) {
//     runApp(const WebViewStack());
//   } else {
//     runApp(const PermissionDeniedScreen());

//   }

    runApp(const WebViewStack());

}
 @override
  void initState() {
    print("initState");

    _checkPermissions();
  }
  Future<void> _checkPermissions() async {
    // Request permissions for camera and microphone
        print("_checkPermissions");

    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }
 
class WebViewStack extends StatelessWidget {
  const WebViewStack({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InAppWebViewPage(),
    );
  }
}
 
class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({super.key});
 
  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}
 
class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? _controller;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://demo-app.sestek.com/iframeloader/sestekloader.html"),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
          mediaPlaybackRequiresUserGesture: false,
          // debuggingEnabled: true,
          ),
        ),
        initialSettings: InAppWebViewSettings(
                // Use initialSettings instead of settings
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
              ),
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                // Automatically grant permissions for camera/microphone
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
        // initialSettings: InAppWebViewSettings(
        //   javaScriptEnabled: true,
        //   mediaPlaybackRequiresUserGesture: false,
        //   allowsInlineMediaPlayback: true,
        //   useHybridComposition: true,
        //   // mediaCapturePermissionGrantType: MediaCapturePermissionGrantType.PROMPT,
        // ),
        onWebViewCreated: (controller) {
          _controller = controller;
 
          controller.addJavaScriptHandler(
            handlerName: 'onClose',
            callback: (args) {
              Navigator.of(context).pop();
            },
          );
        },
        onConsoleMessage: (controller, consoleMessage) {
          print("JS says: ${consoleMessage.message}");
        },
        
      
        onCreateWindow: (controller, createWindowRequest) async {
          await controller.loadUrl(urlRequest: createWindowRequest.request);
          return false;
        },
      ),
    );
  }
}
 
class PermissionDeniedScreen extends StatelessWidget {
  const PermissionDeniedScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Kamera ve mikrofon izinleri gerekli.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
 
 