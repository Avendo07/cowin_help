import 'dart:convert';

import 'package:cowin_help/models/district.dart';
import 'package:cowin_help/models/pin/center.dart' as c;
import 'package:cowin_help/models/state.dart' as s;
import 'package:cowin_help/repository/api_calls.dart';
import 'package:cowin_help/utilities/date_time.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<c.Center> _centers;

  List<c.Center> get centers => _centers;

  List<s.State> _states;

  List<s.State> get states => _states;

  List<District> _districts;
  List<District> get districts => _districts;

  int selectedState=0;
  int selectedDistrict=0;

  Future<List<c.Center>> retrieveList(DateTime date, {int pinCode, int districtId}) async {
    setInitialised(true);
    setBusy(true);

    String _date = DateTimeUtility.formatDate(date);

    List<c.Center> centers;
    Response r;
    if(pinCode!=null)
      r = await sevenDaySchedulePin(_date, pinCode);
    else
      r = await sevenDayScheduleDistrict(_date, districtId);
    print("Sel dis " + selectedDistrict.toString());
    print(r.statusCode);
    if (r.statusCode == 200) {
      print(r.body);
      Map<String, dynamic> m = jsonDecode(r.body);
      List<c.Center> list;
    if(pinCode!=null){
        list = (m["centers"] as List)
            .map((center) => c.Center.fromJson(center))
            .toList();
      }else{
        list = [];
        List l =List<Map<String,dynamic>>.from(m["sessions"]);
        List<Map> newList = convertJson(l);
        print("List new" +newList.toString());
        list = newList.map((center) => c.Center.fromJson(center)).toList();
      }
      print("\n" + r.headers.toString());
      centers = list;
      _centers = list;
    } else {
      print(r.headers);
      centers = [];
      _centers = [];
    }
    setBusy(false);
    return centers;
  }



  Future<List<s.State>> retrieveStates() async {
    setBusy(true);
    Response r = await getStates();
    print(r.statusCode);
    if (r.statusCode == 200) {
      print(r.body);
      Map<String, dynamic> m = jsonDecode(r.body);
      List<s.State> list = (m['states'] as List).map((state) =>
          s.State.fromJson(state)).toList();
      print("\n" + r.headers.toString());
      print("List states" + list[0].stateName);
      _states = list;
    } else {
      print(r.headers);
      _states = [];
    }
    setBusy(false);
    return states;
  }

  Future<List<District>> retrieveDistricts() async {
    if(selectedState==0)
      return [];
    setBusy(true);
    Response r = await getDistricts(selectedState);
    print(r.statusCode);
    if (r.statusCode == 200) {
      print(r.body);
      Map<String, dynamic> m = jsonDecode(r.body);
      List<District> list = (m['districts'] as List).map((district) =>
          District.fromJson(district)).toList();
      print("\n" + r.headers.toString());
      print("List districts" + list[0].districtName);
      _districts = list;
    } else {
      print(r.headers);
      _districts = [];
    }
    setBusy(false);
    return districts;
  }

  storeDistrictList(){
    retrieveDistricts();
  }





  List<DropdownMenuItem<int>> dropDownStates(List<s.State> stateList) {
    List<DropdownMenuItem<int>> list;
    list = stateList.map((state) =>
        DropdownMenuItem(child: Text(state.stateName), value: state.stateId,)).toList();
    list.add(DropdownMenuItem(child: Text("Select State"), value: 0,));
    return list;
  }

  void changeValueStates(int selectedValue){
    selectedState = selectedValue;
    storeDistrictList();
    selectedDistrict=0;
    notifyListeners();
  }

  List<DropdownMenuItem<int>> dropDownDistricts(List<District> districtList) {
    List<DropdownMenuItem<int>> list = [];
    if(selectedState != 0)
    list = districtList.map((district) =>
        DropdownMenuItem(child: Text(district.districtName), value: district.districtId,)).toList();
    list.add(DropdownMenuItem(child: Text("Select District"), value: 0,));
    return list;
  }

  void changeValueDistricts(int selectedValue){
    selectedDistrict = selectedValue;
    notifyListeners();
  }

}

List<Map> convertJson(List l) {
  int current = 1;
  bool first = true;
  List<Map> newList = [];
  List<Map> sessions;
  for (int i=current; i<l.length ; i++) {
    Map<String, dynamic> center = Map<String, dynamic>.from(l[i]);
    if(first){
      sessions = [
        {
          "session_id": center["session_id"],
          "date": center["date"],
          "available_capacity": center["available_capacity"],
          "available_capacity_dose1": center["available_capacity_dose1"],
          "available_capacity_dose2": center["available_capacity_dose2"],
          "fee": center["fee"],
          "min_age_limit": center["min_age_limit"],
          "vaccine": center["vaccine"],
          "slots": center["slots"]
        }
      ];
      first = false;
    }else{
      if(l[i]["center_id"] == l[current]["center_id"]){
        sessions.add({
          "session_id": center["session_id"],
          "date": center["date"],
          "available_capacity": center["available_capacity"],
          "available_capacity_dose1": center["available_capacity_dose1"],
          "available_capacity_dose2": center["available_capacity_dose2"],
          "fee": center["fee"],
          "min_age_limit": center["min_age_limit"],
          "vaccine": center["vaccine"],
          "slots": center["slots"]
        });
      }else{
        sessions = [
          {
            "session_id": center["session_id"],
            "date": center["date"],
            "available_capacity": center["available_capacity"],
            "available_capacity_dose1": center["available_capacity_dose1"],
            "available_capacity_dose2": center["available_capacity_dose2"],
            "fee": center["fee"],
            "min_age_limit": center["min_age_limit"],
            "vaccine": center["vaccine"],
            "slots": center["slots"]
          }
        ];
        center.remove("session_id");
        center.remove("date");
        center.remove("available_capacity");
        center.remove("available_capacity_dose1");
        center.remove("available_capacity_dose2");
        center.remove("fee");
        center.remove("min_age_limit");
        center.remove("vaccine");
        center.remove("slots");
        center.addAll({"sessions": sessions});
        newList.add(center);                                                    //center added to list as the common are already extracted
        current=i;                                                              //Currently comparing this
      }
    }
  }
  return newList;
}
