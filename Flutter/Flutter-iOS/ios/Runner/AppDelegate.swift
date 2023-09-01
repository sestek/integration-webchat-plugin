import UIKit
import Flutter
import sestek_webchat_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let defaultConfiguration = DefaultConfiguration(clientId: "mobile-testing", tenant: "Abdullah", channel: "NdUi", project: "GulfBank", fullName: "Ömer Sezer", customActionData: "{\"channel\":\"mobileapp\",\"operate\":\"ios\"}")
      SestekWebChat.shared.initLibrary(url: "https://nd-test-webchat.sestek.com/chathub", defaultConfiguration: defaultConfiguration)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
