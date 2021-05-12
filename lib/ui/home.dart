import 'dart:convert';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/repository/api_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  static final routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        color: Colors.yellow,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterLogo(style: FlutterLogoStyle.stacked,),
              RaisedButton(onPressed: () async {
                Response r = await sevenDaySchedule("13-05-2021", 110084);
                print(r.statusCode);
                if(r.statusCode == 200){
                  print(r.body);
                  Map<String, dynamic> m = jsonDecode(r.body);
                  List<c.Center> list = (m["centers"] as List).map((center) => c.Center.fromJson(center)).toList();
                  print("Address" + list[0].sessions[0].availableCapacity.toString());
                  print("\n" + r.headers.toString());
                }else{
                  print(r.headers);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
