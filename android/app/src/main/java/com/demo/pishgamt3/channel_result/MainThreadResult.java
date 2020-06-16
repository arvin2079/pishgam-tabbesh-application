package com.demo.pishgamt3.channel_result;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

import androidx.annotation.Nullable;


import io.flutter.plugin.common.MethodChannel;

public class MainThreadResult implements MethodChannel.Result {

    MethodChannel.Result result;
    Handler handler;


    public MainThreadResult(MethodChannel.Result result)
    {
        this.result = result;
        handler=new Handler(Looper.getMainLooper());
    }

    @Override
    public void success(@Nullable Object object)
    {
        handler.post(
                new Runnable() {
                    @Override
                    public void run() {
                        result.success(object);
                    }
                });

    }

    @Override
    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails)
    {

        handler.post(
                new Runnable() {
                    @Override
                    public void run() {
                        result.error(errorCode, errorMessage, errorDetails);
                    }
                });

    }

    @Override
    public void notImplemented() {

        handler.post(
                new Runnable() {
                    @Override
                    public void run() {
                        result.notImplemented();
                    }
                });

    }
}
