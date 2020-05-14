package com.demo.pishgamt3;

import android.os.AsyncTask;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
  public static final String URI_SHOW_PARAMS = "https://tabeshma.000webhostapp.com/mysites/add-user.php";
  String Inquiry="";
//  Send a list of registration information
  HashMap<String,String> Info_for_signin;
  MyHttpUtils myHttpUtils;


  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),SIGN_IN)
            .setMethodCallHandler(((call, result) ->
            {
              if(call.method.equals(""))
              {
                OkHttpClient client=new OkHttpClient();
                String url="https://tabeshma.000webhostapp.com/mysites/showparams.php";
                RequestBody formBody = new FormBody.Builder()
                        .add("email", "eve.holt@reqres.in")
                        .add("password","pistol")
                        .build();

                Request request = new Request.Builder()
                        .url(url)
                        .post(formBody)
                        .build();

                client.newCall(request).enqueue(new Callback() {
                  @Override
                  public void onFailure(Call call, IOException e) {
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
            ((call, result) -> {
              if(call.method.equals(""))
              {
//                The main function is executed here to give and take the parameters
                MyHttpUtils.RequestData requestData =
                        new MyHttpUtils.RequestData(URI_SHOW_PARAMS, "POST");

                requestData.setParameter("firstname", "ali");
                requestData.setParameter("lastname", "ali");
                requestData.setParameter("gender", "male");
                requestData.setParameter("grade", "highschool");
                requestData.setParameter("city", "london");
                requestData.setParameter("phonenumber", "123");
                requestData.setParameter("socialnumber", "7889");
                requestData.setParameter("address", "london");

                new MyTask().execute(requestData);


                result.success(Inquiry);
              }

            })
    );

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
      if(result.contains("user_added"))
      {
        Inquiry="added";

      }
      if(result.contains("cant_add_user"))
      {
        Inquiry="failed";

      }




    }
  }



}
