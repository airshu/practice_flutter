package com.shjlone.practice_flutter

import android.os.Build
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = 0
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor, "methodChannelDemo")
        channel.setMethodCallHandler { call, result ->
                val count: Int? = call.argument<Int>("count")

                //手动切到非UI线程执行耗时操作
                Thread {
                    if (count == null) {
                        result.error("INVALID ARGUMENT", "Value of count cannot be null", null)
                    } else {
                        when (call.method) {
                            // flutter侧会自动切换到主线程
                            "increment" -> result.success(count + 1)
                            "decrement" -> result.success(count - 1)
                            else -> result.notImplemented()
                        }
                    }


                    runOnUiThread(Runnable {
                        //回到UI线程
                        //调用dart侧的方法 参数分别为方法、参数、回调
                        channel.invokeMethod("callDart", "Hello",  object: MethodChannel.Result {
                            override fun success(result: Any?) {
                                Log.d("MainActivity", "result: $result")
                            }

                            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                                Log.e("MainActivity", "errorCode: $errorCode, errorMessage: $errorMessage, errorDetails: $errorDetails")
                            }

                            override fun notImplemented() {
                                Log.e("MainActivity", "notImplemented")
                            }

                        })
                    })



                }.start()

            }


    }
}
