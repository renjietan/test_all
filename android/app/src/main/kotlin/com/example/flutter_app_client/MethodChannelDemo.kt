package com.example.flutter_app_client
import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat.startActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel



class MethodChannelDemo(messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
    private var channel: MethodChannel

    init {
        channel = MethodChannel(messenger, "com.example.flutter_app_client")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "sendData") {
        //     val intent:Intent = Intent(Intent.ACTION_MAIN)
        //     intent.setClassName("com.testapp.myapplication", "com.testapp.myapplication.MainActivity");
        //     startActivity(MainActivity(), intent);
        //    val name = call.argument("name") as String?
        //    val age = call.argument("age") as Int?

        //    var map = mapOf("name" to "hello,$name",
        //            "age" to "$age"
        //    )
            result.success("11111")
        }
    }
}