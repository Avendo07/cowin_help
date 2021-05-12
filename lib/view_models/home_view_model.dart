import 'dart:convert';
import 'package:cowin_help/models/center.dart' as c;
import 'package:cowin_help/repository/api_calls.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';

class HomeViewModel extends BaseViewModel {

  List<c.Center> _centers;
  get centers => _centers;

  Future<List<c.Center>> retrieveList() async {
    List<c.Center> centers;
    Response r = await sevenDaySchedule("13-05-2021", 110084);
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
    return centers;
  }
}
