import 'dart:async';

import 'package:credoapp_example/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash2> with SingleTickerProviderStateMixin {
  var token, lat, long;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late double currentValue;
  late Animation<double> curveAnimation;

  startTime() async {
    var duration = new Duration(seconds: 2);
    return Timer(duration, navigationpage);
  }

  void navigationpage() {
    AppRoutes.makeFirst(context, MyHomePage(title: 'Ficanex'));
    // AppRoutes.replace(context, Languages());
  }

  _splashdelay() async {
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    curveAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    );
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.dispose();
        startTime();
      }
    });
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    // startTime();
    // _splashdelay();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff062636),
      key: _scaffoldKey,
      // backgroundColor: Theme.of(context).bottomAppBarColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splash.png"), fit: BoxFit.scaleDown)),
      ),
    );
  }
}
