package com.demo.pishgamt3.Refrence;

import com.demo.pishgamt3.Method_channels_Strings.ChannelsStrings;

public class Channelname {

    String name[]=new String[100];
    ChannelsStrings signIn = new ChannelsStrings("signin");
    ChannelsStrings signUp = new ChannelsStrings("signup");
    ChannelsStrings getcities = new ChannelsStrings("cities");
    ChannelsStrings getgrades = new ChannelsStrings("grades");
    ChannelsStrings currentUser = new ChannelsStrings("currentuser");
    ChannelsStrings signout = new ChannelsStrings("signout");
    ChannelsStrings acountlessons =new ChannelsStrings("acountlessons");
    ChannelsStrings editprofile=new ChannelsStrings("editprof");
    ChannelsStrings lessons =new ChannelsStrings("lessons");
    ChannelsStrings changePass=new ChannelsStrings("changepass");
    ChannelsStrings image=new ChannelsStrings("Image");
    ChannelsStrings shoppinglist=new ChannelsStrings("shoppinglist");

    public Channelname()
    {
        name[0]=signIn.getChannelsString();
        name[1]=signUp.getChannelsString();
        name[2]=getcities.getChannelsString();
        name[3]=getgrades.getChannelsString();
        name[4]=currentUser.getChannelsString();
        name[5]=signout.getChannelsString();
        name[6]=acountlessons.getChannelsString();
        name[7]=editprofile.getChannelsString();
        name[8]=lessons.getChannelsString();
        name[9]=changePass.getChannelsString();
        name[10]=image.getChannelsString();
        name[11]=shoppinglist.getChannelsString();

    }

    public String[] getName() {
        return name;
    }
}
