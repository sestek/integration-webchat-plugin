
# INTEGRATION SWIFT sestek-webchat-ios PLUGIN in FLUTTER:

● First, let's start a clean flutter project
```javascript
flutter create --org com.yourdomain your_app_name
```
● Skip this step if you have a project

● open vscode

● Note that after opening the project via vscode you should have a podfile.
If there is no podfile, it will create a default when the package is downloaded from
any flutter pub.

● Okey, Podfile now exists and open podfile

![image](https://github.com/sestek/integration-webchat-plugin/assets/52357126/1ef29426-c982-417b-82a1-51f56ae329a8)

● Let's add the latest version of sestek-webchat-ios package via Cocoapods to line 30.
```javascript
cd ios && pod install
```
● We open our Runner.xcworkspace file in the ios folder with xcode. Let's wait for the
file indexing in the window that opens.

● Let's open the AppDelegate.swift file under the Runner folder via Xcode.

```javascript
import sestek_webchat_ios
```
![image](https://github.com/sestek/integration-webchat-plugin/assets/52357126/10d8f490-d936-4b7e-acd6-9ee5a3ce60ed)

● Then we create our defaultConfiguration variable, which we do the basic
configuration
```javascript
let defaultConfiguration = DefaultConfiguration(clientId: "mobile-testing",
tenant: "Abdullah", channel: "NdUi", project: "GulfBank", fullName: "Ömer Sezer",
customActionData: "{\"channel\":\"mobileapp\",\"operate\":\"ios\"}")
SestekWebChat.shared.initLibrary(url:
"https://nd-test-webchat.sestek.com/chathub", defaultConfiguration:
defaultConfiguration)
```
● The integration process is complete. You can run your flutter project for ios from
terminal on VS Code.

● Tested on a flutter project built from scratch.
It contains the latest version of flutter and the latest version of sestek-webchat-ios.

![image](https://github.com/sestek/integration-webchat-plugin/assets/52357126/b0de211f-03f3-4cbe-b89b-6813907ef9c1)![image](https://github.com/sestek/integration-webchat-plugin/assets/52357126/d1b86812-98f4-4133-b221-8b9b7d7bcbae)


