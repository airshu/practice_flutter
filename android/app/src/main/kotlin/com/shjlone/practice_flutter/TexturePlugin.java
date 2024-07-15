package com.shjlone.practice_flutter;

import android.graphics.SurfaceTexture;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class TexturePlugin implements MethodChannel.MethodCallHandler, FlutterPlugin {


    public TexturePlugin(FlutterEngine flutterEngine){

    }


    TextureRegistry textureRegistry;
    MethodChannel channel;
    TextureRegistry.SurfaceTextureEntry surfaceEntry;
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "texture_plugin");
        channel.setMethodCallHandler(this);
        textureRegistry = binding.getTextureRegistry();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map arguments = call.arguments();
        switch (call.method) {
            case "init":
//                int width = arguments["width"];
//                int height = arguments["height"];
//                surfaceEntry = textureRegistry.createSurfaceTexture();
//                SurfaceTexture surfaceTexture = surfaceEntry.surfaceTexture()
//                surfaceTexture.setDefaultBufferSize(width, height);
//                ExternalGLThread(surfaceTexture, SimpleRenderer());
//                createText();
                break;
        }
    }
}
