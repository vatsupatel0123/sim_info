import 'package:flutter/services.dart';
import 'flutter_sim_info_method_channel.dart';
import 'model/sim_info_details.dart';

class FlutterSimInfo {
  static const MethodChannel _channel =
  const MethodChannel('dual_sim_info');

  static final FlutterSimInfoMethodChannel _methodChannel =
  FlutterSimInfoMethodChannel(_channel);

  static FlutterSimInfoMethodChannel get instance => _methodChannel;

  static Future<bool> get hasDualSimSupport => FlutterSimInfo.instance.hasDualSimSupport();
  static Future<List<SimInfoDetails>> get simInfoList => FlutterSimInfo.instance.fetchDeviceSimInfo();
  static Future<String> get deviceId => FlutterSimInfo.instance.getDeviceId();
}
