**add this code in android manifest file for permission**
```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"/>```xml

The READ_PHONE_STATE permission provides access to basic information about the phone state, including the SIM card. The READ_PRIVILEGED_PHONE_STATE permission is for reading privileged information about the phone state, which can be useful for certain use cases.

