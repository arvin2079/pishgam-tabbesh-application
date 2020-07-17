package com.demo.pishgamt3.Method_channels_Strings;

public class Path
{
    String mainPath="http://192.168.1.4:8000";
    String Signup=mainPath+"/signup/";
    String Signin=mainPath+"/api/token/";
    String currentUser=mainPath+"/dashboard/app_profile/";

            public String getMainPath() {
                return mainPath;
            }

            public String getSignup() {
                return Signup;
            }

            public String getSignin() {
                return Signin;
            }

            public String getCurrentUser() {
                return currentUser;
            }
}
