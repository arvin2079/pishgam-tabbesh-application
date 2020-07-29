package com.demo.pishgamt3;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.preference.PreferenceManager;
import android.util.Log;


import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.demo.pishgamt3.Json_parser.JsonParser;
import com.demo.pishgamt3.Method_channels_Strings.Header;
import com.demo.pishgamt3.Refrence.Channelname;
import com.demo.pishgamt3.Refrence.Path;
import com.demo.pishgamt3.Requesr_for_server.RequestforServer;

import com.demo.pishgamt3.Shareprefences.SharePref;
import com.demo.pishgamt3.channel_result.MainThreadResult;


import org.json.JSONException;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends FlutterActivity {

    @RequiresApi(api = Build.VERSION_CODES.N)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {


        //every channels need a string to indentify so we use an class to handle it
        Channelname cs = new Channelname();
        String[] names = cs.getName();

        //routing
        Path path = new Path();


        //signin
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[0])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[0])) {

                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        // prepare construcors params
                        HashMap<String, String> info = new HashMap<>();
                        //request class
                        OkHttpClient client = new OkHttpClient();
                        //set params to hashmap
                        info.put("username", call.argument("username"));
                        info.put("password", call.argument("password"));
                        //Each request requires a header, the key and value of which must be
                        // defined in the hash map with the following strings.
                        info.put(new Header().getKayheader(), new Header().getValueheader());
                        info.put(new Header().getKeyvalue(), new Header().getValueval());
                        //send request
                        RequestforServer requestforServer = new RequestforServer(client, path.getSignin(), info);

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

                                        try {
                                            String message;
                                            switch (response.code()) {
                                                case 400:
                                                    message = "اطلاعات وارد شده نامعتبر میباشد";
                                                    mainresult.error(message, "خطا", null);

                                                    break;
                                                case 401:
                                                    message = "اشکال در اراباط با سرور";
                                                    mainresult.error(message, "خطا", null);
                                                    break;
                                                case 404:
                                                    message = "404";
                                                    mainresult.error(message, "خطا", null);
                                                    break;
                                                case 200:
                                                    //get token and save it  for future requests
                                                    saveToken(response, result);
                                                    break;
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();

                                        }

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
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[2])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[2])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //use get method to get list of cities and grades
                        HashMap<String, String> header = new HashMap<>();
                        header.put(new Header().getKayheader(), new Header().getValueheader());
                        header.put(new Header().getKeyvalue(), new Header().getValueval());
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        //send request
                        RequestforServer requestforServer = new RequestforServer(client, path.getSignup(), header);

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
                                            //send hashmap of cities
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
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[3])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[3])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //use get method to get list of cities and grades
                        HashMap<String, String> header = new HashMap<>();
                        header.put(new Header().getKayheader(), new Header().getValueheader());
                        header.put(new Header().getKeyvalue(), new Header().getValueval());
                        // main class for request
                        OkHttpClient client = new OkHttpClient();
                        RequestforServer requestforServer = new RequestforServer(client, path.getSignup(), header);

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
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[1])
                .setMethodCallHandler((call, result) ->
                {
                    if (call.method.equals(names[1])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //main class for request
                        OkHttpClient client = new OkHttpClient();

                        //create json for request body
                        String json = "{\"username\" : \"" + call.argument("username")
                                + "\" ,\"first_name\" : \"" + call.argument("firstname")
                                + "\" , \"last_name\" : \"" + call.argument("lastname")
                                + "\" ,\"gender\" : \"" + call.argument("gender")
                                + "\" ,\"phone_number\" : \"" + call.argument("phonenumber")
                                + "\" , \"grades\" : [\"" + call.argument("grades")
                                + "\"] , \"city\" : \"" + call.argument("city")
                                + "\" }";

                        //The registration class needs a body made of Jason because the bases must be submitted in the form of a presentation
                        Request request = new Request.Builder()
                                .header(new Header().getValueheader(), new Header().getValueval())
                                .url(path.getSignup())
                                .post(RequestBody
                                        .create(MediaType
                                                .parse("application/json"), json))
                                .build();

                        //send request
                        client.newCall(request).enqueue(new Callback() {
                            @Override
                            public void onFailure(Call call, IOException e) {
                                mainresult.error("خطا", "انجام عملیات ثبت نام در حال حاضر ممکن نیست", null);
                            }

                            @Override
                            public void onResponse(Call call, Response response) throws IOException {
                                if (response.isSuccessful()) {
                                    String message = "هندل نشده";
                                    int responseCode = response.code();
                                    Log.i("my response code ----> ", responseCode + "");

                                    switch (responseCode) {
                                        case 200:
                                            message = "ثبت نام با موفقیت انجام شد";
                                            break;
                                        case 406:
                                            message = "کاربر با این مشخصات موجود می باشد";
                                            Log.i("messssaggeee", message);
                                            break;
                                        case 401:
                                            message = "خطا در برقراری ارتباط با سرور";
                                            break;
                                        default:
                                            message = "اشکال در انجام عملیات ثبت نام";
                                            break;
                                    }

                                    mainresult.success(message);

                                }
                            }
                        });

                    }

                });


        //current user
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[4])
                .setMethodCallHandler((call, result) ->
                {
                    if (call.method.equals(names[4])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //use this class for saving token
                        SharePref pref = new SharePref(getApplicationContext());
                        String token = pref.load("token");
                        //checking file for token
                        Log.i("tokenFromCurrentUser: ", pref.load("token"));
                        if (token == null || token.isEmpty()) result.success(null);
                        else {
                            OkHttpClient client = new OkHttpClient();
                            Request request = new Request.Builder()
                                    .addHeader("Accept", "application/json")
                                    .addHeader("Authorization", "Token " + pref.load("token"))
                                    .url(path.getCurrentuser())
                                    .build();

                            Handler handler = new Handler();
                            handler.post(new Runnable() {
                                @Override
                                public void run() {
                                    client.newCall(request).enqueue(new Callback() {
                                        @Override
                                        public void onFailure(Call call, IOException e) {
                                            mainresult.error("خطا", "خطا در ارتباط با سرور", null);
                                        }

                                        @Override
                                        public void onResponse(Call call, Response response) throws IOException {

                                            JsonParser jsonParser = new JsonParser();
                                            switch (response.code()) {
                                                case 200:
                                                    try {
                                                        mainresult.success(jsonParser.currentUser(response.body().string()));
                                                    } catch (JSONException e) {
                                                        e.printStackTrace();
                                                    } finally {
                                                        break;
                                                    }
                                                case 403:
                                                    mainresult.error("error", "invalid token", null);
                                                    break;
                                                case 406:
                                                    mainresult.error("error", "invalid informatain in header", null);
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    }
                });


        //sign out
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[5])
                .setMethodCallHandler(
                        (call, result) ->
                        {
                            MainThreadResult mainresult = new MainThreadResult(result);
                            try {
                                if (call.method.equals(names[5])) {
                                    //delete token from file
                                    SharedPreferences pref = getApplicationContext().getSharedPreferences("mypref", Context.MODE_MULTI_PROCESS);
                                    SharedPreferences.Editor editor = pref.edit();
                                    editor.remove("token");
                                    editor.apply();
                                }
                            } catch (Exception e) {
                                mainresult.error(e.toString(), "خطا", null);
                            }
                        });

        //arvin's code
        final MediaType JSON = MediaType.parse("application/json; charset=utf-8");


        //lessons

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[6])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[6])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        //load token for header
                        SharePref pref = new SharePref(getApplicationContext());
                        //hashmap for body request
                        HashMap<String, String> header = new HashMap<>();
                        header.put("Accept", "application/json");
                        header.put("Authorization", "Token " + pref.load("token"));

//                                    RequestforServer requestforServer = new RequestforServer(client, path.getAcountlesson(), header);
                        Request request = new Request.Builder()
                                .addHeader("Accept", "application/json")
                                .addHeader("Authorization", "Token " + pref.load("token"))
                                .url(path.getAcountlesson())
                                .build();

                        Log.i("requestt:", request.toString());

                        try {
                            client.newCall(request).enqueue(new Callback() {
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {
                                            mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);
                                        }
                                    });
                                }

                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    int code = response.code();
                                    String resBody = response.body().string();
                                    Log.i("lessons code --- >", code + "");
                                    Log.i("respose body --- >", resBody);
                                    MainActivity.this.runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {

//                                                        String json=response.body().toString();
                                            switch (code) {
                                                case 403:
                                                    mainresult.error("مشکل در ارتباط با سرور", "خطا", null);
                                                    break;
                                                case 200:
                                                    mainresult.success(new JsonParser().lessons(resBody));
                                                    break;

                                            }
                                        }
                                    });

                                }
                            });
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                }));

        //edit prof
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[7])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[7])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //create require params for constructor
                        HashMap<String, String> info = new HashMap<>();
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        //create json for request body
                        String json = "{\"username\" : \"" + call.argument("username")
                                + "\" ,\"first_name\" : \"" + call.argument("firstname")
                                + "\" , \"last_name\" : \"" + call.argument("lastname")
                                + "\" ,\"gender\" : \"" + call.argument("gender")
                                + "\" ,\"email\" : \"" + call.argument("email")
                                + "\" , \"grades\" : [\"" + call.argument("grades")
                                + "\"] , \"city\" : \"" + call.argument("city") + "\" }";

                        //load token for header
                        SharePref pref = new SharePref(getApplicationContext());
                        String token = pref.load("token");
                        //request form
                        Request request = new Request.Builder()
                                .header("Authorization", "Token " + pref.load("token"))
                                .url(path.getEditprof())
                                .post(RequestBody
                                        .create(MediaType
                                                .parse("application/json"), json))
                                .build();
                        client.newCall(request).enqueue(new Callback() {
                            @Override
                            public void onFailure(Call call, IOException e) {
                                mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);


                            }

                            @Override
                            public void onResponse(Call call, Response response) throws IOException {

                                Handler handler = new Handler(Looper.getMainLooper());
                                handler.post(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (response.isSuccessful()) {

                                            mainresult.success("done");
                                        }
                                        if (response.code() == 406) {
                                            mainresult.error("نام کاربری درست نیست", "خطا", null);


                                        }
                                    }
                                });

                            }
                        });


                    }
                }));

        //lessons
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[8])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[8])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //use get method to get list of cities and grades
                        HashMap<String, String> header = new HashMap<>();
                        header.put(new Header().getKayheader(), new Header().getValueheader());
                        header.put(new Header().getKeyvalue(), new Header().getValueval());
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        RequestforServer requestforServer = new RequestforServer(client, path.getLessons(), header);


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
                                            if (response.isSuccessful()) {
                                                String token = response.body().toString();
                                                try {
                                                    mainresult.success(new JsonParser().lessonslist(token));
                                                } catch (JSONException e) {
                                                    mainresult.error("خطا", "خطا", null);

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
                }));

        //change pass
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[9])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[9])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        // prepare construcors params
                        HashMap<String, String> info = new HashMap<>();
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        //load token for header
                        SharePref pref = new SharePref(getApplicationContext());
                        //set params to hashmap
                        info.put("username", call.argument("username"));
                        info.put("password", call.argument("password"));
                        //Each request requires a header, the key and value of which must be
                        // defined in the hash map with the following strings.
                        info.put(new Header().getKayheader(), "Authorization");
                        info.put(new Header().getKeyvalue(), "Token " + pref.load("token"));

                        RequestforServer requestforServer = new RequestforServer(client, path.getEditprof(), info);

                        try {
                            client.newCall(requestforServer.postMethod()).enqueue(new Callback() {
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);


                                }

                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    Handler handler = new Handler(Looper.getMainLooper());
                                    handler.post(new Runnable() {
                                        @Override
                                        public void run() {
                                            if (response.isSuccessful()) {

                                                mainresult.success("done");
                                            }
                                            if (response.code() == 406) {
                                                mainresult.error("نام کاربری درست نیست", "خطا", null);


                                            }
                                        }
                                    });


                                }
                            });
                        } catch (IOException e) {
                            e.printStackTrace();
                        }


                    }

                }));

        //image
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[10])
                .setMethodCallHandler(((call, result) ->
                {
                    if (call.method.equals(names[10])) {
                        //class for sending feedback
                        MainThreadResult mainresult = new MainThreadResult(result);
                        //main class for request
                        OkHttpClient client = new OkHttpClient();
                        //load token for header
                        SharePref pref = new SharePref(getApplicationContext());
                        //prepare imagefile
                        File sourceFile = new File(call.argument("imagepath").toString());
                        //convert file to media for body req
                        final MediaType MEDIA_TYPE_PNG = MediaType.parse("image/*");
                        String filename = call.argument("image_path");
                        //req body
                        RequestBody requestBody = new MultipartBody.Builder()
                                .setType(MultipartBody.FORM)
                                .addFormDataPart("image", filename, RequestBody.create(MEDIA_TYPE_PNG, sourceFile))
                                .build();
                        //reqform
                        Request request = new Request.Builder()
                                .url(path.getEditprof()).addHeader("", "")
                                .header("Authorization", "Token " + pref.load("token"))
                                .post(requestBody)
                                .build();

                        client.newCall(request).enqueue(new Callback() {
                            @Override
                            public void onFailure(Call call, IOException e) {
                                mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);


                            }

                            @Override
                            public void onResponse(Call call, Response response) throws IOException {
                                if (response.isSuccessful()) {
                                    mainresult.success(true);
                                }

                            }
                        });

                    }


                }
                ));

        //shopping list
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), names[11])
                .setMethodCallHandler((call, result) ->
                {
                    if (call.method.equals(names[11])) {

                        MainThreadResult mainresult = new MainThreadResult(result);
                        SharePref pref = new SharePref(getApplicationContext());
                        OkHttpClient client = new OkHttpClient();

                        Request shoppingLessonsRequest = new Request.Builder()
                                .url(path.getShopping())
                                .addHeader("Accept", "application/json")
                                .addHeader("Authorization", "Token " + pref.load("token"))
                                .build();

//                        Request categoriesRequest = new Request.Builder()
//                                .url(path.getCategories())
//                                .addHeader("Accept", "application/json")
//                                .addHeader("Authorization", "Token " + pref.load("token"))
//                                .build();

//                        final String[] responses = new String[2];

                        try {
                            client.newCall(shoppingLessonsRequest).enqueue(new Callback() {
                                @Override
                                public void onFailure(Call call, IOException e) {
                                    mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);
                                }

                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                    int resCode = response.code();
                                    String resBody = response.body().string();

                                    Log.i("resBody@ ", resBody);

                                    if (resCode == 200) {
                                        mainresult.success(resBody);
                                    } else {
                                        mainresult.error("ورود به صفحه خرید در حال حاضر ممکن نیست", "خطا", null);
                                    }
                                }
                            });

//                            client.newCall(categoriesRequest).enqueue(new Callback() {
//                                @Override
//                                public void onFailure(Call call, IOException e) {
//                                    mainresult.error("در حال حاضر ارتباط با سرور ممکن نیست", "خطا", null);
//                                }
//
//                                @Override
//                                public void onResponse(Call call, Response response) throws IOException {
//                                    int resCode = response.code();
//                                    String resBody = response.body().string();
//
//                                    Log.i("resBody@2 ", resBody);
//
//                                    if(resCode == 200) {
//                                        responses[1] = resBody;
//                                    } else {
//                                        mainresult.error("ورود به صفحه خرید در حال حاضر ممکن نیست", "خطا", null);
//                                    }
//                                }
//                            });
//                            if(responses[0] != null && responses[1] != null) {
//                                JsonParser jsonParser = new JsonParser();
//                                mainresult.success(jsonParser.shoppingList(responses[0], responses[1]));
//                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                });


        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

    private void saveToken(Response response, MethodChannel.Result result)
            throws Exception {
        MainThreadResult mainresult = new MainThreadResult(result);
        //        try {
        //convert response to string
        String token = null;
        token = response.body().string();
        Log.i("saved token ---> ", token);
        //parse json
        JsonParser jsonParser = new JsonParser();
        //save token
        Log.i("in saveToken))", "herere1");
        SharePref pref = new SharePref(this);
        Log.i("in saveToken))", "herere2");
        pref.save("token", jsonParser.token(token));
        Log.i("in saveToken))", "herere3");
        mainresult.success(null);
        //        } catch (Exception e) {
        //            mainresult.error("error1" , "failed", null);
        //        }
    }

}
