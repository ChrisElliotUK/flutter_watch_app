import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initFlutterChannel() {
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(
                name: "com.example.com.watch",
                binaryMessenger: controller.binaryMessenger
            )
            channel.setMethodCallHandler({[weak self] (
                call: FlutterMethodCall,
                result: @escaping FlutterResult) -> Void in
                switch call.method {
                case "flutterToWatch":
                    guard let watchSession = self?.session, watchSession.isPaired,
                          watchSession.isReachable, let methodData = call.arguments as [String: Any],
                          let method = methodData["method"], let data = methodData["data"] as? Any else {
                        result(false)
                        return
                    }
                    
                    let watchData: [String: Any] = ["method": method, "data": data]
                    watchSession.sendMessage(watchData, replyHandler: nil, errorHandler: nil)
                    result(true)
                    
                default: result(FlutterMethodNotImplemented)
                }
            })
        }
    }
}
