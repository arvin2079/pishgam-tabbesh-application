package com.demo.pishgamt3;

import android.os.AsyncTask;
import android.view.View;

import androidx.annotation.NonNull;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "authChannel";
    public static final String URI_SHOW_PARAMS = "https://tabeshma.000webhostapp.com/mysites/validation-phone.php";
    String TrueorFalse = "";
    List<AsyncTask> tasks = new ArrayList<>();


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if (call.method.equals("PHONE_NUMBER_VALIDATION")) {
                        MyHttpUtils.RequestData requestData =
                                new MyHttpUtils.RequestData(URI_SHOW_PARAMS, "POST");
                        requestData.setParameter("phone_number", call.argument("phone_number"));

                        new MyTask().execute(requestData);
                        result.success(TrueorFalse);
                    }
                })
        );
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
            if (result == null) {
                result = "null";
            }
            if (result.contains("true")) {
                TrueorFalse = "true";
            } else {
                TrueorFalse = "false";
            }

            tasks.remove(this);

        }
    }


}

