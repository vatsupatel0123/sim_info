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
Run the command `flutter pub get` to install the plugin into your project.
