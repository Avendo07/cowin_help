import 'dart:convert';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/models/session.dart';
import 'package:cowin_help/repository/api_calls.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';

class HomeViewModel extends BaseViewModel {

  int _totalSlots;
  int get slots => _totalSlots;

  List<c.Center> _centers;
  List<c.Center> get centers => _centers;

  Future<List<c.Center>> retrieveList() async {
    setBusy(true);
    List<c.Center> centers;
    Response r = await sevenDaySchedule("15-05-2021", 110084);
    print(r.statusCode);
    if (r.statusCode == 200) {
      print(r.body);
      Map<String, dynamic> m = jsonDecode(r.body);
      List<c.Center> list = (m["centers"] as List)
          .map((center) => c.Center.fromJson(center))
          .toList();
      print("Address" + list[0].sessions[0].availableCapacity.toString());
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
