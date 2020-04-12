import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiMeetingWidget extends StatefulWidget{

  final JitsiMeetingOptions options;

  const JitsiMeetingWidget({Key key, this.options}) : super(key: key);




  @override
  State<StatefulWidget> createState() {
    return _JitsiMeetingWidgetState();
  }
}

class _JitsiMeetingWidgetState extends State<JitsiMeetingWidget>{

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: "JitsiWidget",
        creationParams: widget.options.toJson(),
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: (id){
          print("Created View: $id");
        },
      );
    }else{
      return ErrorWidget("Not Implemented");
    }
    return null;
  }

}