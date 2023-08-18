# Sim Info Plugin

The Sim Info Plugin for Flutter allows you to access and retrieve SIM card information from Android devices within your Flutter app.

## Permissions

To utilize this plugin effectively, you'll need to add certain permissions to your `AndroidManifest.xml` file. These permissions grant your app the necessary access to retrieve SIM card information. Place the following lines in your `AndroidManifest.xml`:

```
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"/>
```

The READ_PHONE_STATE permission provides access to basic information about the phone state, including the SIM card. The READ_PRIVILEGED_PHONE_STATE permission is for reading privileged information about the phone state, which can be useful for certain use cases.

## Installation
To begin using the sim_info plugin in your Flutter project, follow these steps:

1. Open your `pubspec.yaml` file.
2. Add the following lines to your dependencies:

```
dependencies:
  sim_info:
    git:
      url: https://github.com/vatsupatel0123/sim_info.git
      ref: main
```
3. Run the command `flutter pub get` to install the plugin into your project.

## Usage
Once the plugin is installed, you can use it to retrieve SIM card information. Here's an example of how to use it:

```
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
```
