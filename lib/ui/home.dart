import 'dart:convert';
import 'package:cowin_help/view_models/home_view_model.dart';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/repository/api_calls.dart';
import 'package:cowin_help/ui_elements/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import 'package:http/http.dart';

class Home extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool expandedArrow = false;

  @override
  Widget build(BuildContext context) {
    print("Built");
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.retrieveList(),
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
            child: CenterDetailsTile(name: model.centers[0].name, address: model.centers[0].address,)
          ),
        );
      },
    );
    /**/
  }
}

/*CircleAvatar(
maxRadius: 15,
backgroundColor: Colors.yellow,
child: Text("No", style: TextStyle(fontSize: 15.0),),
),*/


/*RaisedButton(onPressed: () async {
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
            })*/
