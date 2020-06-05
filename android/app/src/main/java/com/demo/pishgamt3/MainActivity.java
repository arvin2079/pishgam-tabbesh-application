package com.demo.pishgamt3;

import android.os.Build;


import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.demo.pishgamt3.Json_parser.JsonParser;
import com.demo.pishgamt3.Method_channels_Strings.ChannelsStrings;
import com.demo.pishgamt3.Method_channels_Strings.Header;
import com.demo.pishgamt3.Requesr_for_server.RequestforServer;

import com.demo.pishgamt3.Shareprefences.SharePref;


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
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends FlutterActivity {

  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

      //every channels need a string to indentify so we use an class to handle it
      ChannelsStrings SignIn=new ChannelsStrings("signin");
      ChannelsStrings SignUp=new ChannelsStrings("signup");
      ChannelsStrings ZaringPal=new ChannelsStrings("zarinpal");
      ChannelsStrings Getcities=new ChannelsStrings("cities");
      ChannelsStrings Getgrades=new ChannelsStrings("grades");


    //signin
              new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),SignIn.getChannelsString())
                         .setMethodCallHandler(((call, result) ->
                         {
                        if(call.method.equals("signin"))
                        {
                          // prepare construcors params
                          HashMap<String,String> info=new HashMap<>();
                          String path="http://tabbesh.ir:8000/api/token/";
                          OkHttpClient client=new OkHttpClient();

                          //set params to hashmap
                          info.put("username",call.argument("username"));
                          info.put("password",call.argument("password"));
                          //Each request requires a header, the key and value of which must be
                          // defined in the hash map with the following strings.
                          info.put(new Header().getKayheader(),new Header().getValueheader());
                          info.put(new Header().getKeyvalue(),new Header().getValueval());

                          //send request
                          RequestforServer requestforServer=new RequestforServer(client,path,info);

                            try {
                              //get feedback from server
                              client.newCall(requestforServer.postMethod()).enqueue(new Callback() {
                                //failed response
                                @Override
                                public void onFailure(Call call, IOException e) {
                                  result.error("failed in sign in",e.getMessage(),null);
                                }
                                //request recieved to server so now we can get require feedback
                                @Override
                                public void onResponse(Call call, Response response) throws IOException {
                                  if(response.isSuccessful())
                                      {
                                        MainActivity.this.runOnUiThread(new Runnable() {
                                          @Override
                                          public void run() {
                                            //convert response to string
                                            String token= null;
                                            try {
                                              token = response.body().string();
                                            } catch (IOException e) {
                                              result.error("failed in sign in",e.getMessage(),null);
                                            }
                                            //parse json
                                            JsonParser jsonParser=new JsonParser();
                                            try {
                                              //save token
                                              SharePref pref=new SharePref(getApplicationContext());
                                              pref.save("token",jsonParser.token(token));
                                            } catch (JSONException e) {
                                              result.error("failed in sign in",e.getMessage(),null);
                                            }
                                            //return feedback
                                            result.success(0);
                                          }
                                        });

                                      }
                                  if(response.code()==401)
                                  {
                                    MainActivity.this.runOnUiThread(new Runnable() {
                                      @Override
                                      public void run() {
                                        result.success(1);
                                      }
                                    });
                                  }

                                  else {result.success(null);}

                                }
                              });
                            } catch (IOException e) {
                              result.error("failed in sign in",e.getMessage(),null);
                            }



                        }


                      }
               ));


              //GET for list of cities and grades
              new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),Getcities.getChannelsString())
                          .setMethodCallHandler(((call, result) ->
                          {
                            if(call.method.equals("cities"))
                            {
                              //use get method to get list of cities and grades
                              String path="http://tabbesh.ir:8000/api/token/";
                              HashMap<String,String> header =new HashMap<>();
                              header.put(new Header().getKayheader(),new Header().getValueheader());
                              header.put(new Header().getKeyvalue(),new Header().getValueval());


                              OkHttpClient client=new OkHttpClient();
                              RequestforServer requestforServer=new RequestforServer(client,path,header);

                              try {
                                client.newCall(requestforServer.getMethod()).enqueue(new Callback() {
                                  @Override
                                  public void onFailure(Call call, IOException e) {
                                    result.error("failed in get method",e.getMessage(),null);

                                  }

                                  @Override
                                  public void onResponse(Call call, Response response) throws IOException
                                  {
                                    if(response.isSuccessful())
                                    {
                                        MainActivity.this.runOnUiThread(new Runnable() {
                                          @Override
                                          public void run() {
                                            try {
                                              //get json
                                              String maplist=response.body().string();
                                              //parse json
                                              JsonParser jsonParser=new JsonParser();
                                              //send hashmap
                                              result.success(jsonParser.getcities(maplist));
                                            } catch (IOException | JSONException e) {
                                              result.error("failed in get method",e.getMessage(),null);
                                            }
                                          }
                                        });
                                    }


                                  }
                                });
                              } catch (IOException e) {
                                result.error("failed in get method",e.getMessage(),null);
                              }


                            }

                          }));


              //GET for list of cities and grades
              new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),Getgrades.getChannelsString())
                      .setMethodCallHandler(((call, result) ->
                      {
                        if(call.method.equals("grades"))
                        {
                          //use get method to get list of cities and grades
                          String path="http://tabbesh.ir:8000/api/token/";
                          HashMap<String,String> header =new HashMap<>();
                          header.put(new Header().getKayheader(),new Header().getValueheader());
                          header.put(new Header().getKeyvalue(),new Header().getValueval());


                          OkHttpClient client=new OkHttpClient();
                          RequestforServer requestforServer=new RequestforServer(client,path,header);

                          try {
                            client.newCall(requestforServer.getMethod()).enqueue(new Callback() {
                              @Override
                              public void onFailure(Call call, IOException e) {
                                result.error("failed in get method",e.getMessage(),null);

                              }

                              @Override
                              public void onResponse(Call call, Response response) throws IOException
                              {
                                if(response.isSuccessful())
                                {
                                  MainActivity.this.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                      try {
                                        //get json
                                        String maplist=response.body().string();
                                        //parse json
                                        JsonParser jsonParser=new JsonParser();
                                        //send hashmap
                                        result.success(jsonParser.getgrades(maplist));
                                      } catch (IOException | JSONException e) {
                                        result.error("failed in get method",e.getMessage(),null);
                                      }
                                    }
                                  });
                                }


                              }
                            });
                          } catch (IOException e) {
                            result.error("failed in get method",e.getMessage(),null);
                          }


                        }

                      }));



              //signup
              new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),SignUp.getChannelsString())
                          .setMethodCallHandler(
                          ((call, result) ->
                          {
                            if(call.method.equals("signup"))
                            {
                              //create require params for constructor
                              HashMap<String,String> info=new HashMap<>();
                              String path="http://tabbesh.ir:8000/signup/";
                              OkHttpClient client=new OkHttpClient();

                              //set params to hashmap
                              info.put("firstname",call.argument("username"));
                              info.put("lastname",call.argument("lastname"));
                              info.put("gender",call.argument("gender"));
                              info.put("phonenuber",call.argument("phonenumber"));
                              info.put("grade",call.argument("grade"));
                              info.put("city",call.argument("city"));
                              //Each request requires a header, the key and value of which must be
                              // defined in the hash map with the following strings.
                              info.put(new Header().getKayheader(),new Header().getValueheader());
                              info.put(new Header().getKeyvalue(),new Header().getValueval());


                              //send request
                              RequestforServer requestforServer=new RequestforServer(client,path,info);

                              try {
                                client.newCall(requestforServer.postMethod()).enqueue(new Callback() {
                                  @Override
                                  public void onFailure(Call call, IOException e) {
                                    result.error("failed in sign up",e.getMessage(),null);
                                  }

                                  @Override
                                  public void onResponse(Call call, Response response) throws IOException {
                                    if(response.isSuccessful())
                                    {
                                      switch (response.body().string())
                                      {
                                        case "{'signup_success': 'ثبت نام با موفقیت انجام شد.'}":
                                          result.success(0);
                                          break;
                                        case " { \"non_field_errors\": [\"شماره وارد شده نامعتبر است\"] }  ":
                                          result.success(1);
                                          break;
                                        case "{\"username\": [ \"کاربر با این نام کاربری از قبل موجود است.\"]}"  :
                                          result.success(2);
                                          break;
                                        case  "{ \"non_field_errors\": [\"خطایی رخ داده است . لطفا یک بار دیگر تلاش کنید یا با پشتیبان تماس بگیرید\"] }   ":
                                          result.success(3);
                                          break;
                                        default:
                                          result.success(null);
                                      }
                                    }
                                    if(response.code()==401)result.success(null);
                                    else {result.success(null);}


                                  }
                                });
                              } catch (IOException e) {
                                result.error("failed in sign up",e.getMessage(),null);
                              }

                            }

                          })
              );





    GeneratedPluginRegistrant.registerWith(flutterEngine);

  }






}
