import 'package:cowin_help/models/session.dart';
import 'package:cowin_help/ui_elements/capacity_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateList extends StatelessWidget {
  final Session session;

  const DateList({Key key, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((session.date ?? " ").toString()),
      subtitle: Column(
        children: [
          Text("Vaccine: " + session.vaccine),
          Text("Min Age: " + session.minAge.toString()),
        ],
      ),
      isThreeLine: true,
      trailing: CapacityDisplay(cap: session.availableCapacity,)
    );
  }

  static createSessionList(List<Session> sessions){
    return sessions.map((e) => DateList(session: e,)).toList();
  }

}
