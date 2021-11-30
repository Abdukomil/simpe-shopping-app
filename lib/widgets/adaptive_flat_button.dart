import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(50),
            onPressed: handler(),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
        // ignore: deprecated_member_use
        : FlatButton(
            onPressed: handler(),
            textColor: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
