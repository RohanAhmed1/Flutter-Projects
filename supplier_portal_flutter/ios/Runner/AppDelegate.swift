import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        [GMSServices provideAPIKey:@"AIzaSyAeqThAPBANYOIgu-7Rfw7rtvXCJk2ER4c"];
        [GeneratedPluginRegistrant.register(with: self)];
        // Enable dark mode on iOS
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .dark
        }
        return [super.application(application, didFinishLaunchingWithOptions: launchOptions)]
    }
}
