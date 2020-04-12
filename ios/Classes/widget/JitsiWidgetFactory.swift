//
//  JitsiWidgetFactory.swift
//  jitsi_meet
//
//  Created by Serdar Coşkun on 11.04.2020.
//

import UIKit
import Flutter
class JitsiWidgetFactory: NSObject,FlutterPlatformViewFactory {
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return JitsiWidgetView(frame: frame,identifier: viewId,arguments: args as! [String:Any])
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
}
