# Sim Info Plugin

The Sim Info Plugin for Flutter allows you to access and retrieve SIM card information from Android devices within your Flutter app.

## Permissions

To utilize this plugin effectively, you'll need to add certain permissions to your `AndroidManifest.xml` file. These permissions grant your app the necessary access to retrieve SIM card information. Place the following lines in your `AndroidManifest.xml`:

```
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"/>xml

The READ_PHONE_STATE permission provides access to basic information about the phone state, including the SIM card. The READ_PRIVILEGED_PHONE_STATE permission is for reading privileged information about the phone state, which can be useful for certain use cases.
