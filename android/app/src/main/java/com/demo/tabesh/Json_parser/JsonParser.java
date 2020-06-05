package com.demo.tabesh.Json_parser;

import android.os.Build;

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

                        JSONObject jsonObject=new JSONObject(json);
                        JSONArray  cities=new JSONArray(jsonObject.getJSONArray("cities"));
                        for(int i=0;i<cities.length();i++)
                        {
                            JSONObject city=cities.getJSONObject(i);
                            //get title and code
                            String title=city.getString("title");
                            String code=city.getString("code");
                            //set in hashmap
                            hashMap.put(title,code);

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


      }


