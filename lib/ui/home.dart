import 'dart:convert';
import 'package:cowin_help/view_models/center_list_view_model.dart';
import 'package:cowin_help/view_models/home_view_model.dart';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/repository/api_calls.dart';
import 'package:cowin_help/ui_elements/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import 'package:http/http.dart';

import '../enums.dart';

class Home extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool expandedArrow = false;
  DataSource _source = DataSource.pin;
  TextEditingController tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Built");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ViewModelBuilder<HomeViewModel>.nonReactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model)=> model.setInitialised(false) ,
        builder: (context, homeModel, child) {
          return Column(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: DataSource.pin,
                                groupValue: _source,
                                onChanged: (data) {
                                  setState(() {
                                    _source = data;
                                  });
                                },
                              ),
                              Text("Pin Code")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: DataSource.district,
                                groupValue: _source,
                                onChanged: (data) {
                                  setState(() {
                                    _source = data;
                                  });
                                },
                              ),
                              Text("State And District")
                            ],
                          )
                        ],
                      ),
                      (_source == DataSource.pin)
                          ? Row(
                            children: [
                              Flexible(
                                flex: 9,
                                child: TextField(
                                    maxLength: 6,
                                    maxLines: 1,
                                    controller: tc,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: false, decimal: false),
                                  ),
                              ),
                              RaisedButton(onPressed: (){
                                print("Current Date" + DateTime.now().toString());
                                homeModel.retrieveList(DateTime.now(), int.parse(tc.value.text));
                              }, child: Text("Search"),)
                            ],
                          )
                          : FlutterLogo()
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 14,
                fit: FlexFit.loose,
                child: ViewModelBuilder<CenterListViewModel>.nonReactive(
                  viewModelBuilder: () => CenterListViewModel(),
                  builder: (context, listModel, child) {
                    print(homeModel.centers);
                    if(!homeModel.initialised)
                      return Center(child: Text("Enter the details to fetch data"),heightFactor: 40,);
                    if (homeModel.isBusy) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemBuilder: (context, i) => CenterDetailsTile(
                        address: homeModel.centers[i].address,
                        name: homeModel.centers[i].name,
                        slots: listModel.findTotalSlots(homeModel.centers[i].sessions),
                        minAgeLimit:
                            listModel.findMinAge(homeModel.centers[i].sessions),
                      ),
                      itemCount: homeModel.centers.length,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
    /**/
  }
}
