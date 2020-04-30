package com.demo.pishgamt3;

import android.os.AsyncTask;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "";
  public static final String URI_SHOW_PARAMS = "https://tabeshma.000webhostapp.com/mysites/add-user.php";
  String Inquiry="";
  List<AsyncTask> tasks = new ArrayList<>();
  MyHttpUtils myHttpUtils;


  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(
            ((call, result) -> {
              if(call.method.equals(""))
              {

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


  public class MyTask extends AsyncTask<MyHttpUtils.RequestData, Void, String> {


    @Override
    protected void onPreExecute() {


    }

    @Override
    protected String doInBackground(MyHttpUtils.RequestData... params) {
      MyHttpUtils.RequestData reqData = params[0];

      return MyHttpUtils.getDataHttpUrlConnection(reqData);
    }

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
