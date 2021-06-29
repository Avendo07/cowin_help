import 'dart:convert';

import 'package:cowin_help/models/pin/session.dart';

class Center {
  final int centerId;
  final String name;
  final String address;
  final String stateName;
  final String districtName;
  final String blockName;
  final int pinCode;
  final int lat;
  final int long;
  final String startTime;
  final String endTime;
  final String feeType;

  //final List<VaccineFees> vaccineFees;
  final List<Session> sessions;

  Center({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pinCode,
    this.lat,
    this.long,
    this.feeType,
    this.startTime,
    this.endTime,
    //this.vaccineFees,
    this.sessions,
  });

  Center.fromJson(Map<String, dynamic> _decodedJson)
      : centerId = _decodedJson["center_id"],
        name = _decodedJson["name"],
        address = _decodedJson["address"],
        stateName = _decodedJson["state_name"],
        districtName = _decodedJson["district_name"],
        blockName = _decodedJson["block_name"],
        pinCode = _decodedJson["pincode"],
        lat = _decodedJson["lat"],
        long = _decodedJson["long"],
        feeType = _decodedJson["fee_type"],
        startTime = _decodedJson["from"],
        endTime = _decodedJson["to"],
        //vaccineFees = _decodedJson["vaccine_fees"].map((vaccineFees) => VaccineFees.fromJson(vaccineFees)).toList(),
        sessions = (_decodedJson["sessions"] as List)
            .map((session) => Session.fromJson(Map<String, dynamic>.from(session)))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      "centerId": centerId,
      "name": name,
      "address": address,
      "state_name": stateName,
      "district_name": districtName,
      "block_name": blockName,
      "pincode": pinCode,
      "lat": lat,
      "long": long,
      "fee_type": feeType,
      "from": startTime,
      "to": endTime,
      //"vaccine_fees": vaccineFees,
      "sessions": sessions
    };
  }

  static Center parseCenter(String json) {
    Map<String, dynamic> m = jsonDecode(json);
    Center center = Center.fromJson(m);
    return center;
  }

  String encodeCenter() {
    return jsonEncode(this);
  }
}
