import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'drawer_main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<bool> _onWillPop() async {
    // εδω καθε φορα που ο user κανει swipe για να παει πισω! δλδ στο δευτερο splash screen μας!
    // θα επιστρεφει false δηλαδη "ακυρωνει" to action του user!!
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("SQLite Demo App"),
          ),
          drawer: MainDrawer(context: context),
          body: Center(
            child: Text("SQL DEMO DRAWER WITH INFORMATION"),
          ),
        ),
        onWillPop: _onWillPop);
  }
}
