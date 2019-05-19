import 'package:flutter/material.dart';

import 'package:time_track/view/pages/edit_page.dart';
import 'package:time_track/view/pages/stored_page.dart';

Map<Type, String> staticRoutes = {
  EditPage: '/',
  StoredPage: '/stored',
};

class MainDrawer extends Drawer {
  MainDrawer(BuildContext context, Type page)
      : super(
          child: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text('Drawer'),
                  automaticallyImplyLeading: false,
                ),
                ListTile(
                  title: Text('Edit work times'),
                  enabled: page != EditPage,
                  onTap: () => Navigator.pushReplacementNamed(
                      context, staticRoutes[EditPage]),
                ),
                ListTile(
                  enabled: page != StoredPage,
                  title: Text('Stored work times'),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, staticRoutes[StoredPage]),
                )
              ],
            ),
          ),
        );
}
