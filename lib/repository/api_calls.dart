import 'package:http/http.dart';

Future<Response> sevenDaySchedulePin(String date, int pinCode){
  print(pinCode);
  print("\nDate" + date);
  return get(Uri.parse("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=$pinCode&date=${date.toString()}"));
}

Future<Response> getStates(){
  return get(Uri.parse("https://cdn-api.co-vin.in/api/v2/admin/location/states"));
}

Future<Response> getDistricts(int stateId){
  return get(Uri.parse("https://cdn-api.co-vin.in/api/v2/admin/location/districts/$stateId"));
}

Future<Response> sevenDayScheduleDistrict(String date, int districtId){
  return get(Uri.parse("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$districtId&date=${date.toString()}"));
}
