package com.demo.pishgamt3.Json_parser;

import android.os.Build;
import android.util.Log;
import android.webkit.HttpAuthHandler;

import androidx.annotation.RequiresApi;

import com.demo.pishgamt3.Refrence.Path;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.zip.ZipInputStream;

public class JsonParser {

    public JsonParser() {
    }


    public String SignupOnFailed(String json) throws IOException, JSONException {
        JSONObject JO = new JSONObject(json);
        String result = "";
        if(JO.has("username")) {
            result += JO.getString("username").substring(2, JO.getString("username").length()-2) + " ";
        }

        if(JO.has("phone_number")) {
            result += JO.getString("phone_number").substring(2, JO.getString("phone_number").length()-2) + " ";
        }

        return result;
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
        //fixme : check email
//        hashMap.put("email", jsonObject.getString("email"));
        Path path = new Path();
        hashMap.put("firstname", jsonObject.getString("first_name"));
        hashMap.put("lastname", jsonObject.getString("last_name"));
        hashMap.put("username", jsonObject.getString("username"));
        hashMap.put("grades", jsonObject.getString("grade"));
        hashMap.put("gender", jsonObject.getString("gender"));
        hashMap.put("phone_number", jsonObject.getString("phone_number"));
        hashMap.put("city", jsonObject.getString("cityTitle"));
        hashMap.put("avatar", path.getMainpath() + jsonObject.getString("avatar"));


        return hashMap;
    }

    public HashMap lessons(String json) {
        HashMap hashMap = new HashMap();

        try {
            JSONObject jsonObject = new JSONObject(json);
            hashMap.put("now", jsonObject.getString("now"));
            hashMap.put("timeLeft", jsonObject.getString("calendar_time"));

            JSONArray array = jsonObject.getJSONArray("course_calendars");

            hashMap.put("length", array.length());
            if (array.length() != 0) {
                JSONObject firstCourseJO = array.getJSONObject(0);
                hashMap.put("start_date", firstCourseJO.getString("start_date"));
                hashMap.put("title", firstCourseJO.getString("title"));
                hashMap.put("teacher", firstCourseJO.getString("teacher"));
                hashMap.put("url", firstCourseJO.getString("url"));
                hashMap.put("is_active", firstCourseJO.getBoolean("is_active"));
                hashMap.put("describtion", firstCourseJO.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        //alireza
//                 Log.i("Karray", array.toString());
//                 JSONObject courseObject = array.getJSONObject(0).getJSONObject("course");
//                 Log.i("KcourseObject", courseObject.toString());
//
//                 Log.i("Kteacher", courseObject.getString("teacher"));
//                 Log.i("Ktitle", courseObject.getString("title"));
//                 Log.i("Kimage", courseObject.getString("image"));
//                 Log.i("Kstart_date", array.getJSONObject(0).getString("start_date"));


//                     HashMap<String,String> classes=new HashMap<>();
//                     JSONObject jsonObject1= (JSONObject) jsonArray.get(0);
//                     classes.put("start_date",jsonObject1.getString("start_date"));
//                     classes.put("end_date",jsonObject1.getString("end_date"));
//                     classes.put("url",jsonObject1.getString("url"));
//                     classes.put("is_active",jsonObject1.getString("is_active"));
//                     classes.put("teacher ",jsonObject1.getString("teacher"));
//                     classes.put("title",jsonObject1.getString("title"));
//                     classes.put("image",jsonObject1.getString("image"));

//                 hashMap.put(3,classes);


        return hashMap;

    }

    public HashMap lessonslist(String json) throws JSONException {
        HashMap hashMap = new HashMap();

        JSONArray jsonArray = new JSONArray(json);
        hashMap.put(0, jsonArray.length());
        for (int i = 0; i < jsonArray.length(); i++) {
            HashMap lessons = new HashMap();
            JSONObject jsonObject = (JSONObject) jsonArray.get(i);
            lessons.put("code", jsonObject.getString("code"));
            lessons.put("title", jsonObject.getString("title"));
            lessons.put("start_date", jsonObject.getString("start_date"));
            lessons.put("end_date", jsonObject.getString("end_date"));
            lessons.put("image", jsonObject.getString("image"));
            lessons.put("teacher", jsonObject.getString("teacher"));
            lessons.put("url", jsonObject.getString("url"));
            lessons.put("is_active", jsonObject.getString("is_active"));
            lessons.put("first_class", jsonObject.getString("first_class"));
            lessons.put("description", jsonObject.getString("private_description"));

            hashMap.put(i + 1, lessons);

        }


        return hashMap;
    }

    public ArrayList<HashMap> shoppingList(String json) throws JSONException {
        ArrayList<HashMap> main = new ArrayList<>();

        JSONArray array = new JSONArray(json);

        for(int i=0 ; i<array.length() ; i++) {
            HashMap lesson = new HashMap();
            lesson.put("title", array.getJSONObject(i).getString("title"));
            lesson.put("start_date", array.getJSONObject(i).getString("start_date"));
            lesson.put("end_date", array.getJSONObject(i).getString("end_date"));
            lesson.put("amount", array.getJSONObject(i).getDouble("amount"));
            lesson.put("description", array.getJSONObject(i).getString("description"));
            lesson.put("teacher", array.getJSONObject(i).getString("teacher"));
            lesson.put("image", array.getJSONObject(i).getString("image"));
            lesson.put("parent_id", array.getJSONObject(i).getJSONObject("parent").getInt("id"));
            lesson.put("parent_name", array.getJSONObject(i).getJSONObject("parent").getString("title"));
            lesson.put("first_class_time", array.getJSONObject(i).getJSONArray("course_calendars").getString(0));
            lesson.put("second_class_time", array.getJSONObject(i).getJSONArray("course_calendars").getString(1));
            lesson.put("third_class_time", array.getJSONObject(i).getJSONArray("course_calendars").getString(2));

            main.add(lesson);
        }
        Log.i("final ARRAY--->", main.toString());

        return main;

//        JSONObject lists = new JSONObject(json);
//        JSONArray teachers = lists.getJSONArray("teachers");
//        JSONArray grades = lists.getJSONArray("grades");
//        JSONArray lessons = lists.getJSONArray("lessons");
//
//        main.put(0, teachers.length());
//        main.put(1, grades.length());
//        main.put(2, lessons);
//
//        int[] length = new int[3];
//        length[0] = teachers.length();
//        length[1] = grades.length();
//        length[2] = lessons.length();
//
//        HashMap teacher = new HashMap();
//        HashMap grade = new HashMap();
//        HashMap lesson = new HashMap();
//        int i = 0;
//
//        while (i <= 2) {
//
//
//            for (int j = 0; j < length[i]; j++) {
//                switch (i) {
//                    case 0:
//                        HashMap arrays0 = new HashMap();
//                        JSONObject jsonObject0 = (JSONObject) teachers.get(j);
//
//                        arrays0.put("id", jsonObject0.getString("id"));
//                        arrays0.put("full_name", jsonObject0.getString("full_name"));
//
//                        teacher.put(j, arrays0);
//
//
//                        break;
//
//                    case 1:
//                        HashMap arrays1 = new HashMap();
//                        JSONObject jsonObject1 = (JSONObject) grades.get(j);
//
//                        arrays1.put("id", jsonObject1.getString("id"));
//                        arrays1.put("title", jsonObject1.getString("title"));
//
//                        grade.put(j, arrays1);
//
//                        break;
//
//                    case 2:
//                        HashMap arrays2 = new HashMap();
//                        JSONObject jsonObject2 = (JSONObject) lessons.get(j);
//
//                        arrays2.put("id", jsonObject2.getString("id"));
//                        arrays2.put("title", jsonObject2.getString("title"));
//
//                        lesson.put(j, arrays2);
//
//                        break;
//                }
//
//            }
//            i++;
//
//        }
//
//        main.put(3, teacher);
//        main.put(4, grade);
//        main.put(5, lesson);
//
//
    }

}


