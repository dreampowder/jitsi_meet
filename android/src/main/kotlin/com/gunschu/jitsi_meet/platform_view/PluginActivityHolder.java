package com.gunschu.jitsi_meet.platform_view;

import android.app.Activity;

public class PluginActivityHolder {

    Activity activity;

    private static PluginActivityHolder instance;



    private PluginActivityHolder(){}

    public static PluginActivityHolder getInstance(){
        if (instance == null){
            instance = new PluginActivityHolder();
        }
        return instance;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }
}
