import 'dart:convert';

class State{
  final int stateId;
  final String stateName;

  State({this.stateId, this.stateName});

  State.fromJson(Map<String, dynamic> _decodedJson):
    stateId = _decodedJson["state_id"],
    stateName = _decodedJson["state_name"];

  Map<String, dynamic> toJson(){
    return{
      "state_id": stateId,
      "state_name": stateName
    };
  }

  String encodeVaccineFees(){
    return jsonEncode(this);
  }

}