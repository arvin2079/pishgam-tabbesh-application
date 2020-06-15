package com.demo.pishgamt3.channel_result;

import android.os.Looper;

import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.logging.Handler;
import java.util.logging.LogRecord;

import io.flutter.plugin.common.MethodChannel;

public class MainThreadResult implements MethodChannel.Result {

    MethodChannel.Result result;


    public MainThreadResult(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void success(@Nullable Object object)
    {
        new Thread(new Runnable() {
            @Override
            public void run() {
                result.success(object);
            }
        });




    }

    @Override
    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails)
    {

        new Thread(new Runnable() {
            @Override
            public void run() {
                result.error(errorCode,errorMessage,errorDetails);

            }
        });

    }

    @Override
    public void notImplemented() {

        new Thread(new Runnable() {
            @Override
            public void run() {
                result.notImplemented();

            }
        });

    }
}
