import Flutter
import UIKit
import CoreTelephony

public class SwiftFlutterSimInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dual_sim_info", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSimInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDualSimStatus":
      result(getDualSimStatus())
    case "getDualSimInfo":
      result(getDualSimInfo())
    case "getDeviceId":
      result(getDeviceId())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getDualSimStatus() -> Bool {
    if #available(iOS 12.1, *) {
      let context = CTTelephonyNetworkInfo()
      if let carrier = context.serviceSubscriberCellularProviders?.values.first(where: { $0.isoCountryCode != nil }) {
        return context.serviceSubscriberCellularProviders?.values.contains(where: { $0.isoCountryCode != carrier.isoCountryCode }) ?? false
      }
    }
    return false
  }

  private func getDualSimInfo() -> [String] {
      var simInfoArray: [String] = []

      if #available(iOS 12.1, *) {
          let context = CTTelephonyNetworkInfo()

          for subscription in context.serviceSubscriberCellularProviders?.values ?? [] {
              var simDetails = ""
              if let carrierName = subscription.carrierName {
                  simDetails += "Carrier: \(carrierName), "
              }
              if let isoCountryCode = subscription.isoCountryCode {
                  simDetails += "Country ISO: \(isoCountryCode), "
              }
              if let mobileNetworkCode = subscription.mobileNetworkCode {
                  simDetails += "MNC: \(mobileNetworkCode), "
              }
              // ... Add more relevant properties

              simInfoArray.append(simDetails)
          }
      }

      return simInfoArray
  }

  private func getDeviceId() -> String {
        let identifierForVendor = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let advertisingIdentifier = ASIdentifierManager.shared().advertisingIdentifier.uuidString

        return "Vendor ID: \(identifierForVendor), Advertising ID: \(advertisingIdentifier)"
  }
}
