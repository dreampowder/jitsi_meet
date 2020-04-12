//
//  JitsiWidgetView.swift
//  jitsi_meet
//
//  Created by Serdar Coşkun on 12.04.2020.
//

import UIKit
import JitsiMeet
class JitsiWidgetView: NSObject {
    
    var frame:CGRect
    let identifier:Int64
    var arguments:[String:Any]
    
    var jitsiMeetView:JitsiMeetView!
    var pipViewCoordinator: PiPViewCoordinator?
    
    init(frame:CGRect,identifier:Int64, arguments:[String:Any]) {
        self.frame = frame
        self.identifier = identifier
        self.arguments = arguments
        self.jitsiMeetView =  JitsiMeetView()
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = true
            builder.room = arguments["room"] as? String
            builder.serverURL = URL(string: arguments["serverURL"] as? String ?? "")
            builder.subject = arguments["subject"] as? String
            builder.userInfo?.displayName = arguments["userDisplayName"] as? String
            builder.userInfo?.email = arguments["userEmail"] as? String
            builder.audioOnly = arguments["audioOnly"] as? Bool ?? false
            builder.audioMuted = arguments["audioMuted"] as? Bool ?? false
            builder.videoMuted = arguments["videoMuted"] as? Bool ?? false
        }
        self.jitsiMeetView.join(options)
        
//        pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
//        pipViewCoordinator?.configureAsStickyView(withParentView: jitsiMeetView)
    }
    
}

extension JitsiWidgetView:FlutterPlatformView{
    
    func view() -> UIView {
        self.jitsiMeetView.delegate = self
        return jitsiMeetView
    }
}

extension JitsiWidgetView:JitsiMeetViewDelegate{
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        print("CONFERENCE TERMINATED")
        self.jitsiMeetView = nil
        self.pipViewCoordinator = nil
    }

    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        print("CONFERENCE PIP")
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
