import 'package:flutter/material.dart';

import 'package:time_track/page/edit_page.dart';
import 'package:time_track/page/stored_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        routes: {
          '/': (context) => EditPage(title: 'Tust'),
          '/stored' : (context) => StoredPage(title: 'Test',)
        },
      );
}
