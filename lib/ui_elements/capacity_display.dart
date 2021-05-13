import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CapacityDisplay extends StatelessWidget {
  final int cap;

  const CapacityDisplay({Key key, this.cap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 20,
      minRadius: 1,
      backgroundColor: Colors.yellow,
      child: Text(
        (cap ?? (0)).toString(),
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }
}
