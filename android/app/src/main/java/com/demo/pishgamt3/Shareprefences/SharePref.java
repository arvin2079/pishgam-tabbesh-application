package com.demo.pishgamt3.Shareprefences;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;


import static android.content.Context.MODE_PRIVATE;

public class SharePref {

  private Context context;


            public SharePref(Context context) {
                this.context = context;
            }

            public SharePref() {
            }


                    public void save(String key,String value)
                    {
                        SharedPreferences.Editor pref=context.getSharedPreferences("mypref",Context.MODE_MULTI_PROCESS).edit();
                        pref.putString(key,value);
                        pref.apply();

                    }

                    public String load(String key)
                    {
                        SharedPreferences pref=context.getSharedPreferences("mypref",Context.MODE_MULTI_PROCESS);
                        return pref.getString(key,"");

                    }

                    public void Remove(String name)
                    {
                        SharedPreferences preferences = context.getSharedPreferences("mypref",Context.MODE_MULTI_PROCESS);
                        preferences.edit().remove(name).commit();
                        Log.i("delete token","done");
                    }



}
