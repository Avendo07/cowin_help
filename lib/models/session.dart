import 'dart:convert';

class Session {
  // final String sessionId;
  /*final String startTime;
  final String endTime;*/
  final String date;
  final int availableCapacity;
  final int minAge;
  final String vaccine;
  final List<dynamic> slots;

  Session(
      {this.date,
      this.availableCapacity,
      this.minAge,
      this.vaccine,
      this.slots});

  Session.fromJson(Map<String, dynamic> _decodedJson)
      : date = _decodedJson["date"],
        availableCapacity = _decodedJson["available_capacity"],
        minAge = _decodedJson["min_age_limit"],
        vaccine = _decodedJson["vaccine"],
        slots = _decodedJson["slots"];

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "available_capacity": availableCapacity,
      "min_age_limit": minAge,
      "vaccine": vaccine,
      "slots": slots,
    };
  }

  static Session parseSession(String json) {
    Map<String, dynamic> m = jsonDecode(json);
    Session session = Session.fromJson(m);
    return session;
  }

  String encodeSession() {
    return jsonEncode(this);
  }
}
