package com.example.flutter_sim_info

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.Manifest
import android.annotation.SuppressLint
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
/** FlutterSimInfoPlugin */
class FlutterSimInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var applicationContext: Context

  companion object {
    private const val REQUEST_CODE = 101
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dual_sim_info")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "hasDualSimSupport" -> {
        val hasDualSimStatus = hasDualSimSupport()
        result.success(hasDualSimStatus)
      }
      "fetchDeviceSimInfo" -> {
        val dualSimInfo = fetchDeviceSimInfo()
        result.success(dualSimInfo)
      }
      "fetchDeviceid" -> {
        val deviceId = getDeviceId()
        result.success(deviceId)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
  private fun fetchDeviceSimInfo(): Any {
    if (ActivityCompat.checkSelfPermission(applicationContext, android.Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
      return "Permission Denied"
    }

    val simDetails = mutableListOf<String>()

    val subscriptionManager = applicationContext.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
    val subscriptionInfos: List<SubscriptionInfo> = subscriptionManager.activeSubscriptionInfoList ?: emptyList()
    for (info in subscriptionInfos) {
      val carrierName = info.carrierName?.toString() ?: "Unknown"
      val simNumber = info.number ?: "N/A"
      val slot = info.simSlotIndex
      val countryIso = info.countryIso ?: "N/A"
      simDetails.add("slot: $slot, Carrier: $carrierName, SIM_Number: $simNumber, countryIso: $countryIso")
    }
    return simDetails
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
  private fun hasDualSimSupport(): Any {
    if (ActivityCompat.checkSelfPermission(applicationContext, android.Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
      return "false"
    }

    val subscriptionManager = applicationContext.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
    val subscriptionInfos: List<SubscriptionInfo> = subscriptionManager.activeSubscriptionInfoList ?: emptyList()
    val dualSimInfo = if (subscriptionInfos.size >= 2) {
      "true"
    } else {
      "false"
    }
    return dualSimInfo
  }

  @SuppressLint("HardwareIds")
  private fun getDeviceId(): String {
    var deviceId: String

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      deviceId = Settings.Secure.getString(
        applicationContext.contentResolver,
        Settings.Secure.ANDROID_ID
      )
    } else {
      val mTelephony = applicationContext.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        if (applicationContext.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
          return ""
        }
      }
      deviceId = if (mTelephony.deviceId != null) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
          mTelephony.imei
        } else {
          mTelephony.deviceId
        }
      } else {
        Settings.Secure.getString(
          applicationContext.contentResolver,
          Settings.Secure.ANDROID_ID
        )
      }
    }

    Log.d("deviceId", deviceId)
    return deviceId
  }
}
