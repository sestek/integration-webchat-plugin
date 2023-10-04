
## Flutter Webchat Webview Integration for iOS & Android


1. Install `webview_flutter` package in project.
    
    > 🗒️ Use latest version where possible

2. Create `web_view_stack.dart`

    <img width="750" alt="MicrosoftTeams-image (10)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/af7eaf90-6541-45fc-9da7-3b178550e1bd">


> 🛑 **IMPORTANT**: This is an example, design Webview as per *your* project requirements!

3. Grant permissions:
   
   - `AndroidManifest.xml`
  
     - `android.permission.INTERNET`
     - `android.permission.ACCESS_NETWORK_STATE`
     - `android.permission.WAKE_LOCK`
     - `android.permission.RECORD_AUDIO`
     - `android.permission.MODIFY_AUDIO_SETTINGS`
     - `android.permission.AUDIO_CAPTURE`
  
    - `ios/Runner/Info.plist`
      ```xml
        <key>NSMicrophoneUsageDescription</key>
        <string>WebChat requires acess to microphone.</string> 
      ```

4. Use `WebViewStack` in `main.dart`. Design as per *your* project!

    ```dart
    import 'package:flutter/material.dart';
    import './web_view_stack.dart';
    import 'package:permission_handler/permission_handler.dart';



    void main() async { 

        WidgetsFlutterBinding. ensureInitialized();

        await Permission.microphone.request();

        runApp (
            const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: WebViewApp(),
            ),
        );
    }
        
    class WebViewApp extends StatefulWidget{

        const WebViewApp ({super. key});

        @override
        State«WebViewApp> createState() => _WebViewAppState() ;
    }

    class _WebViewAppState extends State<WebViewApp> {

        @override
        Widget build(BuildContext context) {
            return Scaffold(
                body: SafeArea(child: const WebViewStack()),
            );
        }
    }
    ```

## Sample Screenshot:
<img width="750" alt="MicrosoftTeams-image (14)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/969dd556-6614-4f20-87a3-3d7d1a723b8e">



