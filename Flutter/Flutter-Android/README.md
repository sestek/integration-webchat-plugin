
## WEBCHAT PLUGIN - ANDROID INTEGRATION IN FLUTTER!


•	“webview_flutter” package is installed in the flutter project. (last version recommended)

•	“web_view_stack.dart” file is created.


![1](https://github.com/sestek/integration-webchat-plugin/assets/52357126/aeeea623-e1cb-4748-9dbc-fafb80916abb)


•	WebChat URL is inserted to 37th line, where the uri is parsed.

#### ! IMPORTANT: Webview basic configuration and webview usage structure is entirely designed by the customer. Only an example webview is shared in the document.

•	Since some android versions are also needed, following permissions to the AndroidManifest.xml file under android/src/main is added.

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />

•	After permissions added, “WebViewStack" in our main.dart file is used.

(This is just an example, creating and styling the button is on customer side, since it is purely flutter development and has nothing to do with chat plugin.)


<img width="397" alt="2" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/109a5001-c42b-4c96-b6f6-628f270fff1e">

### Basically, webview is inserted in a flutter project and webchat integration for Android is explained.


<img width="253" alt="3" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/93718cd0-dcfa-4a5d-8d26-2df19277de47">
<img width="252" alt="4" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/c95f4193-0e63-42df-98ee-3d933e47fc08">

