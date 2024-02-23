import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class secondSplash extends StatefulWidget {
  final BuildContext context;

  secondSplash(this.context);

  @override
  State<secondSplash> createState() => _secondSplashState();
}

class _secondSplashState extends State<secondSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset('assets/images/loading-splash.gif'),
        ));
  }
}
