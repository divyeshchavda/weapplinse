package com.app.pocketcoach

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import java.io.File
import android.app.Application
import io.branch.referral.Branch
import android.content.Context
import android.os.BatteryManager

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "whatsapp_share"
    private val BATTERY_CHANNEL = "com.example.methodchannel/battery"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "shareToWhatsApp" -> {
                    val imagePath = call.argument<String>("imagePath")
                    val text = call.argument<String>("text")
                    shareToWhatsApp(imagePath, text)
                    result.success("Shared Successfully")
                }
                "shareToinsta" -> {
                    val imagePath = call.argument<String>("imagePath")
                    val text = call.argument<String>("text")
                    shareToinsta(imagePath, text)
                    result.success("Shared Successfully")
                }
                "shareToface" -> {
                    val imagePath = call.argument<String>("imagePath")
                    val text = call.argument<String>("text")
                    shareToface(imagePath, text)
                    result.success("Shared Successfully")
                }
                else -> result.notImplemented()
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel) // Send battery level to Flutter
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun shareToWhatsApp(imagePath: String?, text: String?) {
        val intent = Intent(Intent.ACTION_SEND)

        when {
            imagePath != null && text != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.whatsapp")
            }
            imagePath != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.setPackage("com.whatsapp")
            }
            text != null -> {
                intent.type = "text/plain"
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.whatsapp")
            }
        }

        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        startActivity(intent)
    }

    private fun shareToinsta(imagePath: String?, text: String?) {
        val intent = Intent(Intent.ACTION_SEND)

        when {
            imagePath != null && text != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.instagram.android")
            }
            imagePath != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.setPackage("com.instagram.android")
            }
            text != null -> {
                intent.type = "text/plain"
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.instagram.android")
            }
        }

        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        startActivity(intent)
    }

    private fun shareToface(imagePath: String?, text: String?) {
        val intent = Intent(Intent.ACTION_SEND)

        when {
            imagePath != null && text != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.facebook.katana")
            }
            imagePath != null -> {
                val imageFile = File(imagePath)
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)

                intent.type = "image/*"
                intent.putExtra(Intent.EXTRA_STREAM, imageUri)
                intent.setPackage("com.facebook.katana")
            }
            text != null -> {
                intent.type = "text/plain"
                intent.putExtra(Intent.EXTRA_TEXT, text)
                intent.setPackage("com.facebook.katana")
            }
        }

        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        startActivity(intent)
    }
}
