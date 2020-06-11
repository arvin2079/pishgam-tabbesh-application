package com.demo.pishgamt3;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.widget.Toast;

import androidx.annotation.NonNull;


import com.zarinpal.ewallets.purchase.OnCallbackRequestPaymentListener;
import com.zarinpal.ewallets.purchase.OnCallbackVerificationPaymentListener;
import com.zarinpal.ewallets.purchase.PaymentRequest;
import com.zarinpal.ewallets.purchase.ZarinPal;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "test";
  Context context;

//  Send the amount payable and the right or wrong will be refunded

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(
            ((call, result) -> {
              if(call.method.equals("test"))
              {
                  result.error("test kardim nasod","chi begam vala",null);
              }

            })
    );

    GeneratedPluginRegistrant.registerWith(flutterEngine);

  }





}
