package com.demo.pishgamt3.Refrence;

public class Path
{
    String mainpath="http://192.168.43.139:8000";
//    String mainpath="http://192.168.1.6:8000";
    String signin=mainpath+ "/api/token/";
    String signup=mainpath+ "/signup/";
    String currentuser=mainpath + "/dashboard/app_profile/";
    String acountlesson=mainpath+ "/dashboard/";
    String editprof=mainpath+ "/dashboard/edit_profile/";
    String lessons=mainpath+ "/dashboard/get-lessons/";
    String Shopping=mainpath + "/dashboard/get-shopping/";


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
