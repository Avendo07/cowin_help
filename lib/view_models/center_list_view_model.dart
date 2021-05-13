import 'dart:convert';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/models/session.dart';
import 'package:cowin_help/repository/api_calls.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';

class CenterListViewModel extends BaseViewModel {

  int _totalSlots;
  int get slots => _totalSlots;

  int findTotalSlots(List<Session> sessions){
    List<int> slots = sessions.map((session) => session.availableCapacity).toList();
    int sum = slots.reduce((value, element) => value + element);
    _totalSlots = sum;
    return sum;
  }

  int findMinAge(List<Session> sessions){
    bool age18 = sessions.any((element) => element.minAge == 18);
    if(age18){
      return 18;
    }else{
      return 45;
    }
  }
}
