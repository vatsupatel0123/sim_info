import 'model/sim_info_details.dart';

abstract class FlutterSimInfoPlatform {
  Future<bool> hasDualSimSupport();
  Future<List<SimInfoDetails>> fetchDeviceSimInfo();
  Future<String> getDeviceId();
}