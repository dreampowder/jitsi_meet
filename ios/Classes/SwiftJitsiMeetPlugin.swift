import Flutter
import UIKit
import JitsiMeet

public class SwiftJitsiMeetPlugin: NSObject, FlutterPlugin {
    
    var window: UIWindow?
    
    var uiVC : UIViewController
    
    init(uiViewController: UIViewController) {
        self.uiVC = uiViewController
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jitsi_meet", binaryMessenger: registrar.messenger())
        JMCallKitProxy.enabled = false;
        let viewController: UIViewController =
            (UIApplication.shared.delegate?.window??.rootViewController)!
        
        let instance = SwiftJitsiMeetPlugin(uiViewController: viewController)
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        registrar.register(JitsiWidgetFactory(), withId: "JitsiWidget")
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "joinMeeting") {
            
            let jitsiViewController: JitsiViewController? = JitsiViewController.init()
            // text = call.argument("text");
            
            guard let args = call.arguments else {
                return
            }
            
            if let myArgs = args as? [String: Any]
            {
                if let roomName = myArgs["room"] as? String {
                    if let serverURL = myArgs["serverURL"] as? String {
                        jitsiViewController?.serverUrl = URL(string: serverURL);
                    }
                    let subject = myArgs["subject"] as? String
                    let displayName = myArgs["userDisplayName"] as? String
                    let email = myArgs["userEmail"] as? String
                    
                    jitsiViewController?.roomName = roomName;
                    jitsiViewController?.subject = subject;
                    jitsiViewController?.jistiMeetUserInfo.displayName = displayName;
                    jitsiViewController?.jistiMeetUserInfo.email = email;
                    if let audioOnly = myArgs["audioOnly"] as? Int {
                        let audioOnlyBool = audioOnly > 0 ? true : false
                        jitsiViewController?.audioOnly = audioOnlyBool;
                    }
                    
                    if let audioMuted = myArgs["audioMuted"] as? Int {
                        let audioMutedBool = audioMuted > 0 ? true : false
                        jitsiViewController?.audioMuted = audioMutedBool;
                    }
                    
                    if let videoMuted = myArgs["videoMuted"] as? Int {
                        let videoMutedBool = videoMuted > 0 ? true : false
                        jitsiViewController?.videoMuted = videoMutedBool;
                    }
                } else {
                    result(FlutterError.init(code: "400", message: "room is null in arguments for method: (joinMeeting)", details: "room is null in arguments for method: (joinMeeting)"))
                }
            } else {
                result(FlutterError.init(code: "400", message: "arguments are null for method: (joinMeeting)", details: "arguments are null for method: (joinMeeting)"))
            }
//            let navigationController = UINavigationController(rootViewController: (jitsiViewController)!)
//            navigationController.modalPresentationStyle = .fullScreen
//            self.uiVC.present(navigationController, animated: true)
            
            jitsiViewController?.modalPresentationStyle = .fullScreen
            self.uiVC.present(jitsiViewController!, animated: true, completion: nil)
            //print("OPEN JITSI MEET CALLED")
        }
        
    }
}
