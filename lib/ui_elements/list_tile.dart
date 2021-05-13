import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterDetailsTile extends StatefulWidget {
  final String name;
  final String address;
  final int slots;
  final int minAgeLimit;

  const CenterDetailsTile(
      {Key key, @required this.name, @required this.address, @required this.slots, @required this.minAgeLimit})
      : super(key: key);

  @override
  _CenterDetailsTileState createState() => _CenterDetailsTileState();
}

class _CenterDetailsTileState extends State<CenterDetailsTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.minAgeLimit>18?Colors.cyan.shade100: Colors.deepOrangeAccent.shade100,
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
            CircleAvatar(
              maxRadius: 20,
              minRadius: 1,
              backgroundColor: Colors.yellow,
              child: Text(
                (widget.slots ?? (0)).toString(),
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            expanded
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down)
          ],
        ),
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
