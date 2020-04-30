package com.demo.pishgamt3;

import android.os.AsyncTask;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  public static final String URI_SHOW_PARAMS = "";
  List<AsyncTask> tasks = new ArrayList<>();

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {


    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }



  public class MyTask extends AsyncTask<MyHttpUtils.RequestData, Void, String> {


    @Override
    protected void onPreExecute() {

      tasks.add(this);
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


      tasks.remove(this);

    }
  }



}
