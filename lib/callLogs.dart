import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'iconFonts/iconFonts.dart';

class CallLogs{

  void call(String text) async{
     bool res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  // avatar check call logs
  getAvator(CallType callType){
    switch(callType){
      case CallType.outgoing:
        return CircleAvatar(maxRadius: 30, foregroundColor: Colors.green, backgroundColor: Colors.greenAccent,);
      case CallType.missed:
        return CircleAvatar(maxRadius: 30, foregroundColor: Colors.red[400], backgroundColor: Colors.red[400],);
      default:
        return CircleAvatar(maxRadius: 30, foregroundColor: Colors.indigo[700], backgroundColor: Colors.indigo[700],);
    }
  }

  // Icon check call logs
  getIcon(CallType callType){
    switch(callType){
      case CallType.outgoing:
        return Icon(MyFlutterApp.call_missed_outgoing, color: Color(0xFF154364), size: 20.0);
      case CallType.missed:
        return Icon(MyFlutterApp.phone_missed, color: Color(0xFF154364), size: 20.0);
      default:
        return Icon(MyFlutterApp.do_not_disturb, color: Color(0xFF154364), size: 20.0);
    }
  }

Future<Iterable<CallLogEntry>> getCallLogs(){
  return CallLog.get();
}
  String formatDate(DateTime dt){
  
      // return DateFormat('d-MMM-y H:m:s').format(dt);
      return DateFormat('hh:mm a').format(dt);
  }

  getTitle(CallLogEntry entry){
    
    if(entry.name == null || entry.name.isEmpty)
      return Text(entry.number);
    else
      return Text(entry.name);
  }

  String getTime(int duration){
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if(d1.inHours > 0){
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if(d1.inMinutes > 0){
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if(d1.inSeconds > 0){
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if(formatedDuration.isEmpty)
      return "0s";
    return formatedDuration;
  }

}