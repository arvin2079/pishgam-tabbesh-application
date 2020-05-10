package com.demo.pishgamt3;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }

  public void SignIn()
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
        Log.i("4444",e.getMessage());
      }

      @Override
      public void onResponse(Call call, Response response) throws IOException
      {
        if(response.isSuccessful())
        {
          final String myresponse=response.body().string();
          Main2Activity.this.runOnUiThread(new Runnable() {
            @Override
            public void run() {

            }
          });
        }

      }
    });
  }

}
