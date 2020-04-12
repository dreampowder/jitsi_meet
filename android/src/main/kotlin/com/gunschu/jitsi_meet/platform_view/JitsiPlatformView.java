package com.gunschu.jitsi_meet.platform_view;

import android.content.Context;
import android.util.Log;
import android.view.View;

import org.jitsi.meet.sdk.JitsiMeetConferenceOptions;
import org.jitsi.meet.sdk.JitsiMeetView;
import org.jitsi.meet.sdk.JitsiMeetViewListener;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

public class JitsiPlatformView implements PlatformView, JitsiMeetViewListener {

    static  final String TAG = "com.gunschu.jitsi_meet.platform_view";
    JitsiMeetConferenceOptions options;
    JitsiMeetView jitsiMeetView;
    public JitsiPlatformView(Context context, JitsiMeetConferenceOptions options) {
        this.options = options;
        jitsiMeetView = new JitsiMeetView(PluginActivityHolder.getInstance().activity);
        jitsiMeetView.join(options);
        jitsiMeetView.setListener(this);
    }

    @Override
    public View getView() {
        return jitsiMeetView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onConferenceJoined(Map<String, Object> map) {
        Log.v(TAG,"onConferenceJoined:"+map);
    }

    @Override
    public void onConferenceTerminated(Map<String, Object> map) {
        Log.v(TAG,"onConferenceTerminated:"+map);
        jitsiMeetView.setListener(null);
        jitsiMeetView.dispose();
    }

    @Override
    public void onConferenceWillJoin(Map<String, Object> map) {
        Log.v(TAG,"onConferenceWillJoin:"+map);
    }
}
