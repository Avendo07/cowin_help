import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterDetailsTile extends StatefulWidget {
  final String name;
  final String address;

  const CenterDetailsTile({Key key, this.name, this.address})
      : super(key: key);

  @override
  _CenterDetailsTileState createState() => _CenterDetailsTileState();
}

class _CenterDetailsTileState extends State<CenterDetailsTile> {
  bool expandedArrow = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.name),
      subtitle: Text(widget.address),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            maxRadius: 15,
            backgroundColor: Colors.yellow,
            child: Text(
              "No",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          expandedArrow
              ? Icon(Icons.keyboard_arrow_up)
              : Icon(Icons.keyboard_arrow_down)
        ],
      ),
      onExpansionChanged: (expanded) {
        if (expanded) {
          setState(() {
            expandedArrow = true;
          });
        } else {
          setState(() {
            expandedArrow = false;
          });
        }
      },
    );
  }
}
