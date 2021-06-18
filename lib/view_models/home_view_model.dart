import 'dart:convert';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/models/district.dart';
import 'package:cowin_help/models/state.dart' as s;
import 'package:flutter/material.dart';
import '../models/session.dart';
import 'package:cowin_help/repository/api_calls.dart';
import 'package:cowin_help/utilities/date_time.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';

class HomeViewModel extends BaseViewModel {
  List<c.Center> _centers;

  List<c.Center> get centers => _centers;

  List<s.State> _states;

  List<s.State> get states => _states;

  List<District> _districts;
  List<District> get districts => _districts;

  int selectedState=0;
  int selectedDistrict=0;

  Future<List<c.Center>> retrieveList(DateTime date, int pinCode) async {
    setInitialised(true);
    setBusy(true);

    String _date = DateTimeUtility.formatDate(date);

    List<c.Center> centers;
    Response r = await sevenDaySchedule(_date, pinCode);
    print(r.statusCode);
    if (r.statusCode == 200) {
      print(r.body);
      Map<String, dynamic> m = jsonDecode(r.body);
      List<c.Center> list = (m["centers"] as List)
          .map((center) => c.Center.fromJson(center))
          .toList();
      //print("Address" + list[0].sessions[0].availableCapacity.toString());
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
