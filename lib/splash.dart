import 'dart:async';

import 'package:credoapp_example/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin {
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

    _splashdelay();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff062636),
      key: _scaffoldKey,
      // backgroundColor: Theme.of(context).bottomAppBarColor,
      body: Stack(
        children: [
          PositionedTransition(
            rect: RelativeRectTween(
                    begin: RelativeRect.fromLTRB(0, 0, 0, 500),
                    end: RelativeRect.fromLTRB(0, 0, 0, 0))
                .animate(curveAnimation),
            child: Center(
              child: Image(
                // width:  MediaQuery.of(context).size.width * 0.3,
                image: AssetImage('images/Bitmap.png'),
                // color: mainColor,
                height: MediaQuery.of(context).size.height * 0.1,
                // width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
          ),
          // PositionedTransition(
          //     rect: RelativeRectTween(
          //             begin: RelativeRect.fromLTRB(0, 0, 0, 600),
          //             end: RelativeRect.fromLTRB(0, 0, 0, 0))
          //         .animate(curveAnimation),
          //     child: Container(
          //       margin: EdgeInsets.all(30),
          //       width: 100,
          //       height: 100,
          //       child: Image(
          //         image: AssetImage('assets/images/languageSCpic.png'),
          //         color: mainColor,
          //         height: MediaQuery.of(context).size.height / 6,
          //       ),
          //       // decoration:
          //       //     BoxDecoration(color: Colors.black12,
          //       //     shape: BoxShape.circle),
          //     )),
        ],
      ),
      //  Container(
      //     width: MediaQuery.of(context).size.width,
      //     height: MediaQuery.of(context).size.height,
      //     decoration: BoxDecoration(
      //         image: DecorationImage(image: AssetImage("images/splash.png"))),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               width: MediaQuery.of(context).size.width,
      //               height: MediaQuery.of(context).size.height * .07,
      //               decoration: BoxDecoration(
      //                   color: Color(0xffFFFDF6),
      //                   image: DecorationImage(
      //                       image: AssetImage("images/splashloading.gif"),
      //                       fit: BoxFit.cover)),
      //             )
      //           ],
      //         ),
      //       ],
      //     )),
    );
  }
}
