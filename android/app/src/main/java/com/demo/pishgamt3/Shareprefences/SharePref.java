package com.demo.pishgamt3.Shareprefences;

import android.content.Context;
import android.content.SharedPreferences;


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
                        SharedPreferences.Editor pref=context.getSharedPreferences("mypref",MODE_PRIVATE).edit();
                        pref.putString(key,value);
                        pref.apply();

                    }

                    public String load(String key)
                    {
                        SharedPreferences pref=context.getSharedPreferences("mypref",MODE_PRIVATE);
                        return pref.getString(key,"wrong key!!!!!");

                    }



}
