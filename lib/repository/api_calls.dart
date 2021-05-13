import 'package:http/http.dart';

Future<Response> sevenDaySchedule(String date, int pinCode){
  print(pinCode);
  print("\nDate" + date);
  return get(Uri.parse("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=$pinCode&date=${date.toString()}"));
}