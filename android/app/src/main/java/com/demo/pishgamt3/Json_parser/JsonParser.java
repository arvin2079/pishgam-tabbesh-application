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


    public String token(String json) throws JSONException {
        JSONObject jsonObject = new JSONObject(json);
        return jsonObject.getString("token");
    }

    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    public HashMap<String, String> getcities(String json) throws JSONException {
        HashMap<String, String> hashMap = new HashMap<>();

        JSONObject jsonObject = new JSONObject(json);
        JSONArray cities = jsonObject.getJSONArray("cities");
        for (int i = 0; i < cities.length(); i++) {
            JSONObject city = cities.getJSONObject(i);
            //get title and code
            String title = city.getString("title");
            String code = city.getString("id");
            //set in hashmap
            hashMap.put(title, code);

        }


        return hashMap;
    }


    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    public HashMap<String, String> getgrades(String json) throws JSONException {
        HashMap<String, String> hashMap = new HashMap<>();

        JSONObject jsonObject = new JSONObject(json);
        JSONArray grades = jsonObject.getJSONArray("grades");
        for (int i = 0; i < grades.length(); i++) {
            JSONObject grade = grades.getJSONObject(i);
            //get title and code
            String title = grade.getString("title");
            String code = grade.getString("id");
            //set in hashmap
            hashMap.put(title, code);

        }

        return hashMap;
    }

    public HashMap<String, String> currentUser(String json) throws JSONException {
        HashMap<String, String> hashMap = new HashMap<>();


        JSONObject jsonObject = new JSONObject(json);

        //test
        Log.i("in JsonParser --->", jsonObject.getString("first_name"));
        Log.i("in JsonParser --->", jsonObject.getString("last_name"));
        Log.i("in JsonParser --->", jsonObject.getString("username"));
        Log.i("in JsonParser --->", jsonObject.getString("grade"));
        Log.i("in JsonParser --->", jsonObject.getString("gender"));
//        Log.i("in JsonParser --->", jsonObject.getString("email"));
        Log.i("in JsonParser --->", jsonObject.getString("avatar"));
        Log.i("in JsonParser --->", jsonObject.getString("phone_number"));
        Log.i("in JsonParser --->", jsonObject.getString("cityTitle"));


        //fixme : check email
//        hashMap.put("email", jsonObject.getString("email"));
        hashMap.put("firstname", jsonObject.getString("first_name"));
        hashMap.put("lastname", jsonObject.getString("last_name"));
        hashMap.put("username", jsonObject.getString("username"));
        hashMap.put("grades", jsonObject.getString("grade"));
        hashMap.put("gender", jsonObject.getString("gender"));
        hashMap.put("phone_number", jsonObject.getString("phone_number"));
        hashMap.put("city", jsonObject.getString("cityTitle"));
        hashMap.put("avatar", jsonObject.getString("avatar"));


        return hashMap;
    }

     public HashMap lessons(String json)
         {
             HashMap hashMap=new HashMap();

             try {
                 JSONObject jsonObject=new JSONObject(json);
                 hashMap.put(0,jsonObject.getString("now")  );
                 hashMap.put(1,jsonObject.getString("calendar_time"));
                 JSONArray jsonArray=(JSONArray) jsonObject.getJSONArray("course_calendars");
                 hashMap.put(2,jsonArray.length());
                 for (int i=0; i<jsonArray.length();i++)
                 {
                     HashMap<String,String> classes=new HashMap<>();
                     JSONObject jsonObject1= (JSONObject) jsonArray.get(i);
                     classes.put("start_date",jsonObject1.getString("start_date"));
                     classes.put("end_date",jsonObject1.getString("end_date"));
                     classes.put("url",jsonObject1.getString("url"));
                     classes.put("is_active",jsonObject1.getString("is_active"));
                     classes.put("teacher ",jsonObject1.getString("teacher"));
                     classes.put("title",jsonObject1.getString("title"));
                     classes.put("image",jsonObject1.getString("image"));

                     hashMap.put(i+2,classes);
                 }


             } catch (JSONException e) {
                 e.printStackTrace();
             }


             return  hashMap;

         }

}


