import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller = window?.rootViewController as! FlutterViewController

    let channel = FlutterMethodChannel(name: "battery", binaryMessenger: controller as! FlutterBinaryMessenger)
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        guard call.method == "getBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.receiveBatteryLevel(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        if batteryLevel < 0.0 {
            print(" -1.0 means battery state is UIDeviceBatteryStateUnknown")
            result(FlutterError(code: "Unavailable", message: "geen dataa fuck", details: nil))
            return
        }
        
        print("Battery Level : \(batteryLevel * 100)%")
        
        result(Int(batteryLevel * 100))
//        if device.batteryState == UIDevice.BatteryState.unknown {
//            result(FlutterError(code: "Unavailable", message: "geen data fuck", details: nil))
//        } else {
//            result(Int(device.batteryLevel * 100))
//        }
    }
}
