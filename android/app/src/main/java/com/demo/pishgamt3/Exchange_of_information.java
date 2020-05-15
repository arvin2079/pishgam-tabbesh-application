package com.demo.pishgamt3;

import android.os.AsyncTask;
import android.os.Build;

import androidx.annotation.RequiresApi;

import java.security.Key;
import java.util.HashMap;
import java.util.Map;

public class Exchange_of_information {
    String url="";
    HashMap<String,String > data;
    String feedback="";
    public Exchange_of_information(HashMap<String, String> data,String url) {
        this.data = data;
        this.url=url;
    }
    @RequiresApi(api = Build.VERSION_CODES.N)
    public void Send_information()
    {
        MyHttpUtils.RequestData requestData =
                new MyHttpUtils.RequestData(url, "POST");
        for (Map.Entry<String, String> entry : data.entrySet()) {
            requestData.setParameter(entry.getKey(),entry.getValue());
        }
        new MyTask().execute(requestData);

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


        //    The answer is clear here
        @Override
        protected void onPostExecute(String result) {
            if(result == null) {
                result = "null";

            }
           feedback=result;




        }
    }




}
