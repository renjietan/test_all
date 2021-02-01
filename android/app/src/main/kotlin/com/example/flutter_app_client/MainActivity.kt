package com.example.flutter_app_client


import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
	val CHANNEL = "com.example.flutter_app_client"
//	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//		super.configureFlutterEngine(flutterEngine)
//		MethodChannelDemo(flutterEngine.dartExecutor.binaryMessenger)
//
//	}
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
	GeneratedPluginRegistrant.registerWith(flutterEngine);

	MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
		if (call.method == "sendData") {
            val intent: Intent = Intent(Intent.ACTION_MAIN)
            intent.setClassName("com.testapp.myapplication", "com.testapp.myapplication.MainActivity");
            startActivity(intent);

		}
	}
}

}
