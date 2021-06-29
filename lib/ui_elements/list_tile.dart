import 'package:cowin_help/models/pin/session.dart';
import 'package:cowin_help/ui_elements/capacity_display.dart';
import 'package:cowin_help/ui_elements/dateList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterDetailsTile extends StatefulWidget {
  final String name;
  final String address;
  final int slots;
  final int minAgeLimit;
  final List<Session> sessions;

  const CenterDetailsTile(
      {Key key, @required this.name, @required this.address, @required this.slots, @required this.minAgeLimit, @required this.sessions})
      : super(key: key);

  @override
  _CenterDetailsTileState createState() => _CenterDetailsTileState();
}

class _CenterDetailsTileState extends State<CenterDetailsTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.minAgeLimit>18?Colors.deepOrangeAccent.shade100: Colors.cyan.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(15.0),
        title: Text(widget.name),
        subtitle: Text(
          widget.address, maxLines: expanded?2:1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CapacityDisplay(cap: widget.slots,),
            expanded
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down)
          ],
        ),
        children: DateList.createSessionList(widget.sessions),
        onExpansionChanged: (e) {
          if (e) {
            setState(() {
              expanded = true;
            });
          } else {
            setState(() {
              expanded = false;
            });
          }
        },
      ),
    );
  }
}
