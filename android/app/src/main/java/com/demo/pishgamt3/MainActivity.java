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
  private static final String CHANNEL = "";
  Context context;

//  Send the amount payable and the right or wrong will be refunded

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(
            ((call, result) -> {
              if(call.method.equals(""))
              {
                  Uri data=getIntent().getData();
                  payment();

//                Use of return routing
                  ZarinPal.getPurchase(context).verificationPayment(data, new OnCallbackVerificationPaymentListener() {
                      @Override
                      public void onCallbackResultVerificationPayment(boolean isPaymentSuccess, String refID, PaymentRequest paymentRequest) {
                       if(isPaymentSuccess)
                       {


                       }
                       else
                           {

                           }
                      }
                  });





              }

            })
    );

    GeneratedPluginRegistrant.registerWith(flutterEngine);

  }

  public void payment()
  {
    //main function
      ZarinPal purchase=ZarinPal.getPurchase(context);
      PaymentRequest payment=ZarinPal.getPaymentRequest();

//    Enter the amount of payment and navigate the reciprocating path of the port
      payment.setAmount(1000);
      payment.setDescription("for test");
      payment.setMerchantID("0c5db223-a20f-4789-8c88-56d78e29ff63");
      payment.setCallbackURL("return://zarinpalpayment");
//    Reply from server
      purchase.startPayment(payment, new OnCallbackRequestPaymentListener() {
          @Override
          public void onCallbackResultPaymentRequest(int status, String authority, Uri paymentGatewayUri, Intent intent) {
              if(status==1000)
              {
                  Toast.makeText(context,"done",Toast.LENGTH_LONG).show();


              }
          }
      });

  }




}
