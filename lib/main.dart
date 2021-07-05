import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_phone_logs/iconFonts/iconFonts.dart';

import 'callLogs.dart';

void main() {
  runApp(CallLogInformations());
}

class CallLogInformations extends StatefulWidget {
  @override
  _CallLogInformationsState createState() => _CallLogInformationsState();
}

class _CallLogInformationsState extends State<CallLogInformations> {
  CallLogs cl = new CallLogs();
  Future<Iterable<CallLogEntry>> logs;

  var marginTop = 0.0;
  @override
  void initState() {
    super.initState();
    logs = cl.getCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Call Log"),
          backgroundColor: Color(0xFF154364),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: marginTop,
            ),
            FutureBuilder(
                future: logs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Iterable<CallLogEntry> entries = snapshot.data;
                    if (!snapshot.hasData) {
                      marginTop = 30.0;
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Loading ...'),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: ListTile(
                                dense: true,
                                // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                leading: cl.getIcon(
                                    entries.elementAt(index).callType),
                                title: Transform.translate(
                                  child: cl.getTitle(entries.elementAt(index)),
                                  offset: Offset(-20.0, 0),
                                ),
                                subtitle: Transform.translate(child: Text(entries.elementAt(index).number),
                                offset: Offset(-20.0, 0)),
                                isThreeLine: true,
                                trailing: Container(
                                  width: 190,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(cl.formatDate(new DateTime
                                                  .fromMillisecondsSinceEpoch(
                                              entries
                                                  .elementAt(index)
                                                  .timestamp)), style: TextStyle(fontSize: 13.0),),
                                      SizedBox(width: 10,),
                                      Row(
                                        children: [
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(width: 1, color: Color(0xFF23C084))),
                                          child:Icon(MyFlutterApp.call, color: Color(0xFF23C084), size: 19.0),
                                      ),
                                      SizedBox(width: 8,),
                                      Icon(MyFlutterApp.comments, color: Color(0xFF154364), size: 20.0),
                                      SizedBox(width: 8,),
                                      Icon(MyFlutterApp.info_circled, color: Color(0xFF23C084), size: 20.0),
                                      SizedBox(width: 8,),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(width: 1, color: Color(0xFF23C084))),
                                          child: Icon(MyFlutterApp.plus, color: Color(0xFF154364), size: 20.0),
                                        ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                            onLongPress: () => {},
                          );
                        },
                        itemCount: entries.length,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
