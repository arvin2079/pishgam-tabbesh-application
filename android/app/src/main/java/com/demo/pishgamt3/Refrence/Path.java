package com.demo.pishgamt3.Refrence;

import android.util.Log;

public class Path {
    //    String mainpath="http://192.168.43.139:8000";
    String mainpath = "http://192.168.1.5:8000";
    String signin = mainpath + "/api/token/";
    String signup = mainpath + "/signup/";
    String currentuser = mainpath + "/dashboard/app_profile/";
    String acountlesson = mainpath + "/dashboard/";
    String editprof = mainpath + "/dashboard/edit_profile/";
    String lessons = mainpath + "/dashboard/get-lessons/";
    String Shopping = mainpath + "/dashboard/get-shopping/";
    String files = mainpath + "/dashboard/lessons/files/";

    public String getFilesPath(String id) {
        Log.i("pathshshshhs", files + id.trim() + "/");
        return files + id.trim() + "/";
    }

    public String getCategories() {
        return categories;
    }

    String categories = mainpath + "/dashboard/shopping/";


    public String getMainpath() {
        return mainpath;
    }

    public String getSignin() {
        return signin;
    }

    public String getSignup() {
        return signup;
    }

    public String getCurrentuser() {
        return currentuser;
    }

    public String getAcountlesson() {
        return acountlesson;
    }

    public String getEditprof() {
        return editprof;
    }

    public String getLessons() {
        return lessons;
    }

    public String getShopping() {
        return Shopping;
    }
}
