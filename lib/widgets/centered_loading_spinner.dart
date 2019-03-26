import 'package:flutter/material.dart';

class CenteredLoadingSpinner extends StatelessWidget {
  CenteredLoadingSpinner({this.text});

  String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(text)
          ],
        ),
      );
}
