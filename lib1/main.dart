// @dart=2.9
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:credoapp_example/screens/nextscreen.dart';
import 'package:credoapp_example/showdata.dart';
import 'package:credoapp_example/splash.dart';
import 'package:credoapp_example/splash2.dart';
import 'package:credoapp_example/utils/colors.dart';
import 'package:credoapp_example/utils/const.dart';
import 'package:credoapp_example/utils/custombutton.dart';
import 'package:credoapp_example/utils/customtextfield.dart';
import 'package:credoapp_example/utils/route.dart';
import 'package:credoapp_example/utils/styles.dart';
// import 'package:credoappsdk/credoappsdk.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void dialogBox() {
  EasyLoading.instance
    ..backgroundColor = mainColor
    ..progressColor = greenColor
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10
    ..textColor = mainColor2
    ..indicatorColor = mainColor2
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
    ..indicatorSize = 100;
}

void main() async {
  dialogBox();
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

const platform = const MethodChannel('app.channel.shared.data');

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ficanex',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            // Splash2()
            Splash()
        //  AnimatedSplashScreen(
        //     duration: 100,
        //     splashIconSize: 1000,
        //     splash: Container(
        //       width: 500,
        //       height: 1000,
        //       child: Image.asset(
        //         "images/scoring.png",
        //         width: 500,
        //         fit: BoxFit.fill,
        //         height: 100,
        //       ),
        //     ),
        //     nextScreen: const MyHomePage(title: 'Ficanex'),
        //     splashTransition: SplashTransition.decoratedBoxTransition,
        //     // pageTransitionType: PageTransitionType,
        //     backgroundColor: mainColor)
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataShared = "No Data";
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController offerCode = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  var width, height;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        // backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Color(0xff062636),
          // leading: Padding(
          //   padding: EdgeInsets.only(left: width * .02),
          //   child:
          // ),
          automaticallyImplyLeading: false,
          // title: Text(
          //   "Ficanex",
          //   style: headingStyle.copyWith(
          //       fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          // ),
          actions: [
            Image.asset(
              "images/Bitmap.png",
              width: width * .5,
              // fit: BoxFit.cover,
              height: height * .08,
              // color: Colors.blue[300],
            ),
            Container(
              width: width * .48,
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          width: width,
          height: height,
          // color: Colors.white,
          padding: EdgeInsets.all(width * .02),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/home.png"), fit: BoxFit.cover)),
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * .85,
                              height: height * .8,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * .03),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Get Prequalified Today",
                                        style: headingStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  heading("Full Name"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        // controller: pass,
                                        pass: false, controller: controller,
                                        width: width * .8,
                                        validator: (String value) =>
                                            value.isEmpty
                                                ? "Please enter Full Name"
                                                : null,
                                        title: "Enter Full Name",
                                        number: false,
                                        keyboardTypenumeric: false,
                                        height: height * 06,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  heading("Email"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        controller: email,
                                        pass: false,
                                        width: width * .8,
                                        validator: (String value) =>
                                            value.isEmpty
                                                ? "Please enter Email"
                                                : null,
                                        title: "Enter Email",
                                        number: false,
                                        keyboardTypenumeric: false,
                                        height: height * 06,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  heading("Phone"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        // controller: pass,
                                        pass: false,
                                        controller: mobileNo,

                                        width: width * .8,
                                        title: "Enter Phone",
                                        validator: () {
                                          return null;
                                        },
                                        number: true,
                                        keyboardTypenumeric: true,
                                        height: height * 06,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  heading("Offer Code"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        controller: offerCode,
                                        pass: false,
                                        width: width * .8,
                                        validator: (String value) =>
                                            value.isEmpty
                                                ? "Please enter Offer Code"
                                                : null,
                                        title: "Enter Offer Code",
                                        number: false,
                                        keyboardTypenumeric: false,
                                        height: height * 06,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: width * .02, left: width * .02),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          "The information captured here will not be shared with anyone.  Only score will be shared with the lender.",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: headingStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     // await platform
                                      //     //     .invokeMethod("getSharedText");

                                      //     if (controller.text.isEmpty ||
                                      //         email.text.isEmpty ||
                                      //         offerCode.text.isEmpty) {
                                      //       Flushbar(
                                      //         message:
                                      //             "Please Enter Required Fields!",
                                      //         flushbarPosition:
                                      //             FlushbarPosition.TOP,
                                      //         duration: Duration(seconds: 3),
                                      //         leftBarIndicatorColor:
                                      //             Colors.blue[300],
                                      //         onTap: (value) {
                                      //           // navigatorKey.currentState.push(MaterialPageRoute(
                                      //           //   builder: (_) => PendingOrderTracking(),

                                      //           // ));
                                      //         },
                                      //       )..show(context);
                                      //     } else {
                                      //       AppRoutes.push(
                                      //           context, NextScreen());
                                      //     }
                                      //     //   bool isValid = EmailValidator.validate(
                                      //     //       controller1.text);
                                      //     //   if (isValid) {

                                      //     //   } else {
                                      //     //     // ignore: avoid_single_cascade_in_expression_statements
                                      //     //     Flushbar(
                                      //     //       message:
                                      //     //           "Please Enter Valid Email Address!",
                                      //     //       flushbarPosition:
                                      //     //           FlushbarPosition.TOP,
                                      //     //       duration: Duration(seconds: 3),
                                      //     //       leftBarIndicatorColor:
                                      //     //           Colors.blue[300],
                                      //     //       onTap: (value) {
                                      //     //         // navigatorKey.currentState.push(MaterialPageRoute(
                                      //     //         //   builder: (_) => PendingOrderTracking(),

                                      //     //         // ));
                                      //     //       },
                                      //     //     )..show(context);
                                      //     //   }
                                      //     // }
                                      //   },
                                      //   child: CustomButton(
                                      //     width: width * .45,
                                      //     height: height * .06,
                                      //     color: mainColor,
                                      //     title: "Next",
                                      //   ),
                                      // ),

                                      GestureDetector(
                                        onTap: () async {
                                          // await platform
                                          //     .invokeMethod("getSharedText");

                                          if (controller.text.isEmpty ||
                                              email.text.isEmpty ||
                                              offerCode.text.isEmpty) {
                                            Flushbar(
                                              message:
                                                  "Please Enter Required Fields!",
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              duration: Duration(seconds: 3),
                                              leftBarIndicatorColor:
                                                  Colors.blue[300],
                                              onTap: (value) {
                                                // navigatorKey.currentState.push(MaterialPageRoute(
                                                //   builder: (_) => PendingOrderTracking(),

                                                // ));
                                              },
                                            )..show(context);
                                          } else {
                                            customDialog(
                                                context,
                                                "Mobile scoring will analyze metadata and other non-persoanl data on your phone and calculate a score that does not look at any of your personal information. Do you agree that we may collect this information",
                                                email.text,
                                                mobileNo.text,
                                                offerCode.text);
                                          }
                                          //   bool isValid = EmailValidator.validate(
                                          //       controller1.text);
                                          //   if (isValid) {

                                          //   } else {
                                          //     // ignore: avoid_single_cascade_in_expression_statements
                                          //     Flushbar(
                                          //       message:
                                          //           "Please Enter Valid Email Address!",
                                          //       flushbarPosition:
                                          //           FlushbarPosition.TOP,
                                          //       duration: Duration(seconds: 3),
                                          //       leftBarIndicatorColor:
                                          //           Colors.blue[300],
                                          //       onTap: (value) {
                                          //         // navigatorKey.currentState.push(MaterialPageRoute(
                                          //         //   builder: (_) => PendingOrderTracking(),

                                          //         // ));
                                          //       },
                                          //     )..show(context);
                                          //   }
                                          // }
                                        },
                                        child: CustomButton(
                                          width: width * .45,
                                          height: height * .06,
                                          color: mainColor,
                                          title: "Score me!",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget heading(title) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .00),
      child: Row(
        children: [
          SizedBox(
            width: width * .03,
          ),
          Text(
            "$title*",
            style: headingStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
