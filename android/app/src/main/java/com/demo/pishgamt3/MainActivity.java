package com.demo.pishgamt3;

import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.zarinpal.ewallets.purchase.OnCallbackRequestPaymentListener;
import com.zarinpal.ewallets.purchase.OnCallbackVerificationPaymentListener;
import com.zarinpal.ewallets.purchase.PaymentRequest;
import com.zarinpal.ewallets.purchase.ZarinPal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends FlutterActivity {
  private static final String SIGN_UP = "signup";
  private static final String SIGN_IN= "signin";
  private static final String ZARIN_PALL = "zarinpall";

  public static final String url="http://tabbesh.ir:83/signup/";
  int Inquiry=-1;
//  Send a list of registration information
  HashMap<String,String> Info_for_signin;
  HashMap<String,String> Info_for_signup;

  MyHttpUtils myHttpUtils;


  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),SIGN_IN)
            .setMethodCallHandler(((call, result) ->
            {
              if(call.method.equals("signin"))
              {
                OkHttpClient client=new OkHttpClient();
                String url="https://tabeshma.000webhostapp.com/mysites/showparams.php";
                RequestBody formBody = new FormBody.Builder()
                        .add("username", call.argument("username"))
                        .add("password",call.argument("password"))
                        .build();

                Request request = new Request.Builder()
                        .url(url)
                        .post(formBody)
                        .build();

                client.newCall(request).enqueue(new Callback() {
                  @Override
                  public void onFailure(Call call, IOException e) {
                    // todo : onFaillure return null
                    Info_for_signin = null;
                    Log.i("failed in sign_in",e.getMessage());
                  }

                  @Override
                  public void onResponse(Call call, Response response) throws IOException
                  {
                    if(response.isSuccessful())
                    {
                      final String myresponse=response.body().string();
                      MainActivity.this.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                          try {
                            String json=      JWTUtils.decoded(myresponse);

                            Info_for_signin= JsonParser.pareJson(json);
                          } catch (Exception e) {
                            e.printStackTrace();
                          }


                        }
                      });
                    }

                  }
                });

                result.success(Info_for_signin);

              }


            }
            ));
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),SIGN_UP).setMethodCallHandler(
            ((call, result) ->
            {
              if(call.method.equals("signup"))
              {
                // fixme : remove address and socialnumber
//                The main function is executed here to give and take the parameters
                Info_for_signup.put("firstname",call.argument("firstname"));
                Info_for_signup.put("lastname",call.argument("lastname"));
                Info_for_signup.put("socialnumber",call.argument("socialnumber"));
                Info_for_signup.put("phonenumber",call.argument("phonenumber"));
                Info_for_signup.put("grade",call.argument("grade"));
                Info_for_signup.put("city",call.argument("city"));
                Info_for_signup.put("gender",call.argument("gender"));
                Info_for_signup.put("address",call.argument("address"));
             //create hashmap for send to server by connecting to flutter and send it to exchange

                MyHttpUtils.RequestData requestData =
                        new MyHttpUtils.RequestData(url, "POST");
                for (Map.Entry<String, String> entry : Info_for_signup.entrySet()) {
                  requestData.setParameter(entry.getKey(),entry.getValue());
                }
                new MyTask().execute(requestData);

                 result.success(Inquiry);





              }

            })
    );

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),ZARIN_PALL)
            .setMethodCallHandler((call, result) ->
            {
              if(call.method.equals("zarinpall"))
              {
                ZarinPal purchase=ZarinPal.getPurchase(getApplicationContext());
                PaymentRequest payment=ZarinPal.getPaymentRequest();
                payment.setMerchantID("0c5db223-a20f-4789-8c88-56d78e29ff63");
                payment.setAmount(call.argument("amount"));
                payment.setDescription("تست جهت برنامه");
                payment.setCallbackURL("return://zarinpalpayment");

                purchase.startPayment(payment, new OnCallbackRequestPaymentListener() {
                  @Override
                  public void onCallbackResultPaymentRequest(int status, String authority, Uri paymentGatewayUri, Intent intent) {
                    if(status==100) startActivity(intent);
                    else Toast.makeText(getApplicationContext(),"پرداخت با موفقیت انجام نشد",Toast.LENGTH_LONG).show();
                  }
                });
              }

              Uri data=getIntent().getData();
              ZarinPal.getPurchase(this).verificationPayment(data,new OnCallbackVerificationPaymentListener(){

                @Override
                public void onCallbackResultVerificationPayment(boolean isPaymentSuccess, String refID, PaymentRequest paymentRequest) {
                  if(isPaymentSuccess)
                  {
                   result.success("done");
                  }else
                  {
                    result.success("failed");

                  }
                }
              });



            });

    GeneratedPluginRegistrant.registerWith(flutterEngine);

  }






//  As an employee, he does the work in MyTask and returns the answer that
//  is determined for him. Here is the connection with the server.

  public class MyTask extends AsyncTask<MyHttpUtils.RequestData, Void, String> {


    @Override
    protected void onPreExecute() {


    }

    @Override
    protected String doInBackground(MyHttpUtils.RequestData... params) {
      MyHttpUtils.RequestData reqData = params[0];

      return MyHttpUtils.getDataHttpUrlConnection(reqData);
    }


//    The answer is clear here
    @Override
    protected void onPostExecute(String result) {
      if(result == null) {
        result = "null";

      }
      if(result.contains("ثبت نام با موفقیت انجام شد")) Inquiry=0;
      if(result.contains("شماره وارد شده نامعتبر است")) Inquiry=1;
      if(result.contains("کاربر با این نام کاربری از قبل موجود است")) {
       Inquiry=2;
      }
      if(result.contains("خطایی رخ داده است . لطفا یک بار دیگر تلاش کنید یا با پشتیبان تماس بگیرید")) Inquiry=3;




    }
  }



}
