import 'dart:convert';

class District{
  final int districtId;
  final String districtName;

  District({this.districtId, this.districtName});

  District.fromJson(Map<String, dynamic> _decodedJson):
        districtId = _decodedJson["district_id"],
        districtName = _decodedJson["district_name"];

  Map<String, dynamic> toJson(){
    return{
      "district_id": districtId,
      "district_name": districtName
    };
  }

  String encodeVaccineFees(){
    return jsonEncode(this);
  }

}