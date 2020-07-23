package com.demo.pishgamt3;

import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;


import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.demo.pishgamt3.Json_parser.JsonParser;
import com.demo.pishgamt3.Method_channels_Strings.ChannelsStrings;
import com.demo.pishgamt3.Method_channels_Strings.Header;
import com.demo.pishgamt3.Requesr_for_server.RequestforServer;

import com.demo.pishgamt3.Shareprefences.SharePref;
import com.demo.pishgamt3.channel_result.MainThreadResult;


import org.json.JSONException;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends FlutterActivity {

    @RequiresApi(api = Build.VERSION_CODES.N)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {


        //every channels need a string to indentify so we use an class to handle it
        ChannelsStrings SignIn = new ChannelsStrings("signin");
        ChannelsStrings SignUp = new ChannelsStrings("signup");
        ChannelsStrings ZaringPal = new ChannelsStrings("zarinpal");
        ChannelsStrings Getcities = new ChannelsStrings("cities");
        ChannelsStrings Getgrades = new ChannelsStrings("grades");
        ChannelsStrings CurrentUser = new ChannelsStrings("currentuser");
        ChannelsStrings Signout = new ChannelsStrings("signout");

        //server address :
        final String servAd = "http://192.168.1.6:8000";


        //signin
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), SignIn.getChannelsString())
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals("signin")) {
                        //test1
                        Log.i("signin arguments ---> ", call.arguments.toString());

                        MainThreadResult mainresult = new MainThreadResult(result);


                        // prepare construcors params
                        HashMap<String, String> info = new HashMap<>();
                        String path = servAd + "/api/token/";
                        OkHttpClient client = new OkHttpClient();

                        //set params to hashmap
                        info.put("username", call.argument("username"));
                        info.put("password", call.argument("password"));
                        //Each request requires a header, the key and value of which must be
                        // defined in the hash map with the following strings.
                        info.put(new Header().getKayheader(), new Header().getValueheader());
                        info.put(new Header().getKeyvalue(), new Header().getValueval());

                        //send request
                        RequestforServer requestforServer = new RequestforServer(client, path, info);

                        try {
                            //get feedback from server
                            client.newCall(requestforServer.postMethod()).enqueue(new Callback() {
                                //failed response
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);
                                }

                                //request recieved to server so now we can get require feedback
                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    if (response.isSuccessful()) {
                                        MainActivity.this.runOnUiThread(new Runnable() {
                                            @Override
                                            public void run() {

                                                try {
                                                    String message;
                                                    switch (response.code()) {
                                                        case 400:
                                                            message = "اطلاعات وارد شده نامعتبر میباشد";
                                                            break;
                                                        case 401:
                                                            message = "اشکال در اراباط با سرور";
                                                            break;
                                                        case 404:
                                                            message = "404";
                                                            break;
                                                        case 200:
                                                            saveToken(response, result);
                                                            break;
                                                    }
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                    mainresult.error("error2", "failed", null);
                                                }
                                            }
                                        });

                                    } else if (response.code() == 401) {
                                        MainActivity.this.runOnUiThread(new Runnable() {
                                            @Override
                                            public void run() {
                                                mainresult.error("خطا در انجام مراحل ثبت نام", "خطا", null);
                                            }
                                        });
                                    } else {
                                        Log.i("response code :", "" + response.code());
                                        mainresult.error("رمز عبور نادرست", "خطا", null);
                                    }
                                }
                            });
                        } catch (IOException e) {
                            mainresult.error("failed in sign in", e.getMessage(), null);
                        }


                    }


                }));


        //GET for list of cities and grades
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), Getcities.getChannelsString())
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals("cities")) {
                        MainThreadResult mainresult = new MainThreadResult(result);

                        //use get method to get list of cities and grades
                        String path = servAd + "/signup/";
                        HashMap<String, String> header = new HashMap<>();
                        header.put(new Header().getKayheader(), new Header().getValueheader());
                        header.put(new Header().getKeyvalue(), new Header().getValueval());


                        OkHttpClient client = new OkHttpClient();
                        RequestforServer requestforServer = new RequestforServer(client, path, header);

                        try {
                            client.newCall(requestforServer.getMethod()).enqueue(new Callback() {
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    mainresult.error("دریافت لیست شهر ها از سوی سرور در حال حاضر مقدور نیست", "خطا", null);

                                }

                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    if (response.isSuccessful())
                                        try {
                                            //get json
                                            String maplist = response.body().string();
                                            //parse json

                                            JsonParser jsonParser = new JsonParser();
                                            //send hashmap
                                            HashMap<String, String> map = jsonParser.getcities(maplist);
                                            mainresult.success(map);
                                        } catch (IOException | JSONException e) {
                                            mainresult.error("failed in get method", e.getMessage(), null);
                                        }

                                }
                            });
                        } catch (IOException e) {
                            mainresult.error("failed in get method", e.getMessage(), null);
                        }


                    }

                }));


        //GET for list of cities and grades
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), Getgrades.getChannelsString())
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals("grades")) {
                        MainThreadResult mainresult = new MainThreadResult(result);


                        //use get method to get list of cities and grades
                        String path = servAd + "/signup/";
                        HashMap<String, String> header = new HashMap<>();
                        header.put(new Header().getKayheader(), new Header().getValueheader());
                        header.put(new Header().getKeyvalue(), new Header().getValueval());


                        OkHttpClient client = new OkHttpClient();
                        RequestforServer requestforServer = new RequestforServer(client, path, header);

                        try {
                            client.newCall(requestforServer.getMethod()).enqueue(new Callback() {
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    mainresult.error("دریافت لیست شهر ها از سوی سرور در حال حاضر مقدور نیست", "خطا", null);

                                }

                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    if (response.isSuccessful()) {
                                        try {
                                            //get json
                                            String maplist = response.body().string();
                                            //parse json
                                            JsonParser jsonParser = new JsonParser();
                                            //send hashmap
                                            mainresult.success(jsonParser.getgrades(maplist));
                                        } catch (IOException | JSONException e) {
                                            mainresult.error("failed in get method", e.getMessage(), null);
                                        }
                                    }

                                }
                            });
                        } catch (IOException e) {
                            mainresult.error("failed in get method", e.getMessage(), null);
                        }


                    }

                }));

        //signup
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), SignUp.getChannelsString())
                .setMethodCallHandler(
                        (call, result) ->
                        {
                            if (call.method.equals("signup")) {
                                MainThreadResult mainresult = new MainThreadResult(result);

                                //create require params for constructor
                                HashMap<String, String> info = new HashMap<>();
                                String path = servAd + "/signup/";
                                OkHttpClient client = new OkHttpClient();

//                                String json = "{\"username\" : " + call.argument("username") + "," +
//                                        "\"first_name\" : " + call.argument("firstname") + " ," +
//                                        " \"last_name\" :" + call.argument("lastname") + "," +
//                                        "\"gender\" : " + call.argument("gender") + " ," +
//                                        "\"phone_number\" : " + call.argument("phonenumber") + ", " +
//                                        "\"grades\" : " + "[" + call.argument("grades") + "] " + ", " +
//                                        "\"city\" : " + call.argument("city") + " }";
//                                Log.i("my request json ----> ", json);

                                String json = "{\"username\" : \"" + call.argument("username") + "\" ,\"first_name\" : \"" + call.argument("firstname") + "\" , \"last_name\" : \"" + call.argument("lastname") + "\" ,\"gender\" : \"" + call.argument("gender") + "\" ,\"phone_number\" : \"" + call.argument("phonenumber") + "\" , \"grades\" : [\"" + call.argument("grades") + "\"] , \"city\" : \"" + call.argument("city") + "\" }";
                                Log.i("second jasonbody--->", json);

                                Request request = new Request.Builder()
                                        .header(new Header().getValueheader(), new Header().getValueval())
                                        .url(path)
                                        .post(RequestBody
                                                .create(MediaType
                                                        .parse("application/json"), json))
                                        .build();

//                                Log.i("my request body ----> ", request.body().toString());


                                //set params to hashmap

                                //send request

                                client.newCall(request).enqueue(new Callback() {
                                    @Override
                                    public void onFailure(Call call, IOException e) {
                                        mainresult.error("خطا", "انجام عملیات ثبت نام در حال حاضر ممکن نیست", null);
                                    }

                                    @Override
                                    public void onResponse(Call call, Response response) throws IOException {
                                        Log.i("my response code ----> ", response.code() + "");
                                        if (response.isSuccessful()) {
                                            String message;
                                            switch (response.code()) {
                                                case 200:
                                                    message = "ثبت نام با موفقیت انجام شد";
                                                    break;
                                                case 406:
                                                    message = "کاربر با این مشخصات موجود می باشد";
                                                    break;
                                                case 401:
                                                    message = "خطا در برقراری ارتباط با سرور";
                                                    break;
                                                default:
                                                    message = "اشکال در انجام عملیات ثبت نام";
                                                    break;
                                            }
                                            Log.i("messsssage--->", message);
                                            mainresult.success(message);
//                                            switch (response.body().string()) {
//                                                case "{'signup_success': 'ثبت نام با موفقیت انجام شد.'}":
//                                                    mainresult.success("ثبت نام با موفقیت انجام شد");
//                                                    break;
//                                                case " { \"non_field_errors\": [\"شماره وارد شده نامعتبر است\"] }  ":
//                                                    mainresult.error("خطا", "شماره وارد شده نامعتبر است", null);
//                                                    break;
//                                                case "{\"username\": [ \"کاربر با این نام کاربری از قبل موجود است.\"]}":
//                                                    mainresult.error("خطا", "کاربر با این نام کاربری از قبل موجود است", null);
//                                                    break;
//                                                case "{ \"non_field_errors\": [\"خطایی رخ داده است . لطفا یک بار دیگر تلاش کنید یا با پشتیبان تماس بگیرید\"] }   ":
//                                                    mainresult.error("خطا", "در انجام عملیبات ثبت نام خطایی رخ داده است . لطفا یک بار دیگر تلاش کنید یا با پشتیبان تماس بگیرید", null);
//                                                    break;
//                                                default:
//                                                    mainresult.error("خطا", "ثبت نام ناموفق", null);
//                                            }
                                        }
                                    }
                                });

                            }

                        });


        //current user
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CurrentUser.getChannelsString())
                .setMethodCallHandler((call, result) ->
                {
                    if (call.method.equals("currentuser")) {
                        Log.i("TAG", "enter to currentuser");
                        MainThreadResult mainresult = new MainThreadResult(result);

                        SharePref pref = new SharePref(getApplicationContext());
                        String token = pref.load("token");
                        Log.i("user token :: ", token);
                        if (token == null || token.isEmpty()) result.success(null);
                        else {
                            //use get method to get list of cities and grades
                            String path = servAd + "/dashboard/app_profile/";
                            HashMap<String, String> header = new HashMap<>();
                            header.put(new Header().getKayheader(), "Authorization");
                            header.put(new Header().getKeyvalue(), "Token " + pref.load("token"));


                            OkHttpClient client = new OkHttpClient();
                            RequestforServer requestforServer = new RequestforServer(client, path, header);

                            try {
                                client.newCall(requestforServer.getMethod()).enqueue(new Callback() {
                                    @Override
                                    public void onFailure(Call call, IOException e) {
                                        mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);
                                    }

                                    @Override
                                    public void onResponse(Call call, Response response) throws IOException {

                                        MainActivity.this.runOnUiThread(new Runnable() {
                                            @Override
                                            public void run() {
                                                if (response.code() == 403)
                                                    mainresult.error("مشکل در ارتباط با سرور", "خطا", null);

                                                else {
                                                    try {
                                                        String message = response.body().string();
                                                        mainresult.success(new JsonParser().currentUser(message));

                                                    } catch (Exception e/* | JSONException e*/) {
                                                        e.printStackTrace();

                                                    }
                                                }
                                            }
                                        });

                                    }
                                });
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }

                    }


                });

        //sign out
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), Signout.getChannelsString())
                .setMethodCallHandler((call, result) ->
                {
                    MainThreadResult mainresult = new MainThreadResult(result);
                    try {
                        if (call.method.equals("signout")) {
                            SharePref signout = new SharePref();
                            signout.save("token", null);
                            mainresult.success(true);
                        }
                    } catch (Exception e) {
                        mainresult.error(e.toString(), "خطا", null);
                    }
                });


        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

    private void saveToken(Response response, MethodChannel.Result result) throws JSONException{
        MainThreadResult mainresult = new MainThreadResult(result);
//        try {
            //convert response to string
            String token = null;
            token = response.body().string().trim();
        Log.i("saved token ---> ", token);
            //parse json
            JsonParser jsonParser = new JsonParser();
            //save token
            SharePref pref = new SharePref(getApplicationContext());
            pref.save("token", jsonParser.token(token));
            mainresult.success(null);
//        } catch (Exception e) {
//            mainresult.error("error1" , "failed", null);
//        }
    }

}
