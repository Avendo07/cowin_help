import 'dart:convert';

class VaccineFees {
  final String vaccine;
  final String fee;

  VaccineFees({this.vaccine, this.fee});

  VaccineFees.fromJson(Map<String, dynamic> _decodedJson):
    vaccine = _decodedJson["vaccine"],
    fee = _decodedJson["fee"];

  Map<String, dynamic> toJson() {
    return {
      "vaccine": vaccine,
      "fee": fee,
    };
  }

  static VaccineFees parseSession(String json) {
    Map<String, dynamic> m = jsonDecode(json);
    VaccineFees fees = VaccineFees.fromJson(m);
    return fees;
  }

  String encodeVaccineFees() {
    return jsonEncode(this);
  }
}
