package com.demo.pishgamt3;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class JsonParser {

    public static HashMap<String, String> pareJson(String json) throws JSONException {
        HashMap hashMap=new HashMap();
        JSONObject mainJson= new JSONObject(json);
        JSONObject jsonObject=mainJson.getJSONObject("Info");

        hashMap.put("first_name",jsonObject.getString("first_name"));
        hashMap.put("last_name",jsonObject.getString("last_name"));
        hashMap.put("user_name",jsonObject.getString("user_name"));
        hashMap.put("password",jsonObject.getString("password"));
        hashMap.put("gender",jsonObject.getString("gender"));
        hashMap.put("phone_number",jsonObject.getString("phone_number"));
        hashMap.put("grades",jsonObject.getString("grades"));


       return  hashMap;
    }

}
