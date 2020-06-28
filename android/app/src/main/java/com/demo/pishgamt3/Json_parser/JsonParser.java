package com.demo.pishgamt3.Json_parser;

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class JsonParser {

        public JsonParser() {
        }


                    public String token(String json) throws JSONException
                    {
                        JSONObject jsonObject=new JSONObject(json);
                        return jsonObject.getString("token");
                    }

                    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
                    public HashMap<String,String> getcities(String json) throws JSONException
                    {
                        HashMap<String,String> hashMap=new HashMap<>();

                        Log.i("jason PARSER", "getcities: here1");
                        JSONObject jsonObject=new JSONObject(json);
                        Log.i("jason PARSER", "getcities: here2");
                        JSONArray  cities=new JSONArray(jsonObject.getJSONArray("cities"));
                        Log.i("jason PARSER", "getcities: here3");
                        for(int i=0;i<cities.length();i++)
                        {
                            Log.i("jason PARSER", "getcities: inFor1" + i);
                            JSONObject city=cities.getJSONObject(i);
                            Log.i("jason PARSER", "getcities: inFor2" + i);
                            //get title and code
                            String title=city.getString("title");
                            String code=city.getString("code");
                            //set in hashmap
                            Log.i("jason PARSER", "getcities: inFor3" + i);
                            hashMap.put(title,code);
                            Log.i("jason PARSER", "getcities: inFor4" + i);

                        }


                     return hashMap;
                    }


                    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
                    public HashMap<String,String> getgrades(String json) throws JSONException
                    {
                        HashMap<String,String> hashMap=new HashMap<>();

                        JSONObject jsonObject=new JSONObject(json);
                        JSONArray  grades=new JSONArray(jsonObject.getJSONArray("grades"));
                        for(int i=0;i<grades.length();i++)
                        {
                            JSONObject grade=grades.getJSONObject(i);
                            //get title and code
                            String title=grade.getString("title");
                            String code=grade.getString("code");
                            //set in hashmap
                            hashMap.put(title,code);

                        }

                        return hashMap;
                    }

                    public HashMap<String,String> currentUser(String json) throws JSONException
                    {
                            HashMap<String,String> hashMap=new HashMap<>();

                            JSONObject jsonObject=new JSONObject(json);
                            hashMap.put("firstname",jsonObject.getString("first_name"));
                            hashMap.put("lastname",jsonObject.getString("last_name"));
                            hashMap.put("username",jsonObject.getString("username"));
                            hashMap.put("email",jsonObject.getString("email"));
                            hashMap.put("grades",jsonObject.getString("grades"));
                            hashMap.put("gender",jsonObject.getString("gender"));
                            hashMap.put("phone_number",jsonObject.getString("phone_number"));
                            hashMap.put("city",jsonObject.getString("city"));
                            hashMap.put("avatar",jsonObject.getString("avatar"));


                        return hashMap;
                    }


      }


