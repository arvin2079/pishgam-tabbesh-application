package com.demo.pishgamt3.Method_channels_Strings;

public class Path
{
    String mainPath="http://192.168.1.7:8000";
    String signin=mainPath+"/api/token/";
    String signup=mainPath+"/signup/";
    String currentUser=mainPath+"/dashboard/edit_profile/";


            public String getMainPath() {
                return mainPath;
            }

            public String getSignin() {
                return signin;
            }

            public String getSignup() {
                return signup;
            }

            public String getCurrentUser() {
                return currentUser;
            }
}
