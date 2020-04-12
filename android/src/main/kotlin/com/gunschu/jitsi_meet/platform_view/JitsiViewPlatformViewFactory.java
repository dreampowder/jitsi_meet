package com.gunschu.jitsi_meet.platform_view;

import android.content.Context;

import org.jitsi.meet.sdk.JitsiMeetConferenceOptions;
import org.jitsi.meet.sdk.JitsiMeetUserInfo;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class JitsiViewPlatformViewFactory extends PlatformViewFactory {

    public JitsiViewPlatformViewFactory(MessageCodec<Object> createArgsCodec) {
        super(createArgsCodec);
    }
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        JitsiMeetConferenceOptions options = null;
        if (args instanceof HashMap){
            HashMap map = (HashMap)args;
            String roomUrl = map.get("serverURL")+"/"+map.get("room");
            JitsiMeetUserInfo jitsiMeetUserInfo = new JitsiMeetUserInfo();
            jitsiMeetUserInfo.setDisplayName(getStringValue(map.get("userDisplayName")));
            jitsiMeetUserInfo.setEmail(getStringValue("userEmail"));
            try {
                jitsiMeetUserInfo.setAvatar(new URL(getStringValue(map.get("userAvatarURL"))));
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
            options = new JitsiMeetConferenceOptions.Builder()
                    .setRoom(roomUrl)
                    .setSubject(getStringValue(map.get("subject")))
                    .setToken(getStringValue(map.get("token")))
                    .setAudioMuted(getBoolValue(map.get("audioMuted")))
                    .setAudioOnly(getBoolValue(map.get("audioOnly")))
                    .setVideoMuted(getBoolValue("videoMuted"))
                    .setUserInfo(jitsiMeetUserInfo)
                    .build();
        }
        return new JitsiPlatformView(context,options);
    }

    private boolean getBoolValue(Object value){
        if (value == null){
            return false;
        }else{
            if (value instanceof  Boolean){
                return  ((Boolean)value);
            }else{
                return false;
            }
        }
    }

    private String getStringValue(Object value){
        return value == null ? "" : value.toString();
    }
}
