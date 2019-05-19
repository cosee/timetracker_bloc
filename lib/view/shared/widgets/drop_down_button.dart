import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  DropDownButton({this.buttonText, this.onPressed});

  String buttonText;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Text(buttonText),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
