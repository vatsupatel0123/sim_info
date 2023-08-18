import 'package:flutter/services.dart';
import 'flutter_sim_info_platform_interface.dart';
import 'model/sim_info_details.dart';

class FlutterSimInfoMethodChannel implements FlutterSimInfoPlatform {
  final MethodChannel _channel;

  FlutterSimInfoMethodChannel(this._channel);

  @override
  Future<bool> hasDualSimSupport() async {
    String status = await _channel.invokeMethod('hasDualSimSupport');
    return bool.parse(status);
  }

  @override
  Future<List<SimInfoDetails>> fetchDeviceSimInfo() async {
    final dualSimInfo = await _channel.invokeMethod('fetchDeviceSimInfo');
    List<SimInfoDetails> simInfoListnew = [];
    SimInfoDetails? parsedSimInfoList;
    for (String inputString in dualSimInfo) {
      parsedSimInfoList = parseStringToSimInfoList(inputString);
      simInfoListnew.add(parsedSimInfoList!);
    }
    return simInfoListnew;
  }

  @override
  Future<String> getDeviceId() async {
    return await _channel.invokeMethod('fetchDeviceid');
  }

  parseStringToSimInfoList(String input) {
    print("String input = ${input}");
    List<String> keyValuePairs = input.split(',');
    for (String pair in keyValuePairs) {
      List<String> keyValue = pair.trim().split(':');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();

        if (key == 'slot') {
          String slot = value;
          String carrier = '';
          String simNumber = '';
          String countryIso = '';

          for (String nextPair in keyValuePairs) {
            List<String> nextKeyValue = nextPair.trim().split(':');
            if (nextKeyValue.length == 2) {
              String nextKey = nextKeyValue[0].trim();
              String nextValue = nextKeyValue[1].trim();

              if (nextKey == 'Carrier') {
                carrier = nextValue;
              } else if (nextKey == 'SIM_Number') {
                simNumber = nextValue;
              } else if (nextKey == 'countryIso') {
                countryIso = nextValue;
              }
            }
          }

          return SimInfoDetails(slot: int.parse(slot), carrier: carrier, simNumber: simNumber, countryIso: countryIso);
        }
      }
    }
  }
}
