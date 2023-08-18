import 'package:flutter/material.dart';
import 'package:flutter_sim_info/flutter_sim_info.dart';
import 'package:flutter_sim_info/model/sim_info_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sim Info Plugin Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                bool dualSimStatus = await FlutterSimInfo.hasDualSimSupport;
                print('Dual SIM status: $dualSimStatus');
              },
              child: Text('Get Dual SIM Status'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<SimInfoDetails> dualSimInfo = await FlutterSimInfo.simInfoList;
                print('Dual SIM Info: $dualSimInfo');
              },
              child: Text('Get Dual SIM Info'),
            ),
            ElevatedButton(
              onPressed: () async {
                String deviceId = await FlutterSimInfo.deviceId;
                print('Device ID: $deviceId');
              },
              child: Text('Get Device ID'),
            ),
          ],
        ),
      ),
    );
  }
}
