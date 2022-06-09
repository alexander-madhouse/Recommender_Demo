import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:credoapp_example/showdata.dart';
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

//@dart=2.9
void dialogBox() {
  EasyLoading.instance
    ..backgroundColor = walmartBlueColor
    ..progressColor = greenColor
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10
    ..textColor = walmartWhiteColor
    ..indicatorColor = walmartWhiteColor
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle
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
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scoring Result',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            duration: 100,
            splashIconSize: 1000,
            splash: Container(
              width: 500,
              height: 1000,
              child: Image.asset(
                "images/walmart_white.png",
                width: 500,
                fit: BoxFit.fill,
                height: 100,
              ),
            ),
            nextScreen: const MyHomePage(title: 'CredoApp SDK Example'),
            splashTransition: SplashTransition.decoratedBoxTransition,
            // pageTransitionType: PageTransitionType,
            backgroundColor: walmartBlueColor));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataShared = "No Data";
  bool isLoading = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController govId = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  var width, height;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: walmartBlueColor,
          title: Image.asset('images/walmart_spark_logo_text_blue.png'),
          centerTitle: true,
          toolbarHeight: 90.0,
        ),
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          padding: EdgeInsets.all(width * .02),
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "¡Pre califica hoy mismo!",
                              style: headingStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: walmartBlueColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * .04,
                        ),
                        heading("Nombre y apellidos"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              // controller: pass,
                              pass: false, controller: fullName,
                              width: width * .85,
                              validator: (String value) => value.isEmpty
                                  ? "Please enter Full Name"
                                  : null,
                              title: "Ingresa nombre y apellidos",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        heading("Correo electrónico"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: email,
                              pass: false,
                              width: width * .85,
                              validator: (String value) =>
                                  value.isEmpty ? "Please enter Email" : null,
                              title: "Ingresa correo electrónico",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        heading("Número celular"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              // controller: pass,
                              pass: false,
                              controller: mobileNo,

                              width: width * .85,
                              title: "Ingresa número celular",
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
                        heading("Número de tu identificación (INE / IFE)"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: govId,
                              pass: false,
                              width: width * .85,
                              validator: (String value) =>
                                  value.isEmpty ? "Please enter Gov ID" : null,
                              title: "Ingresa número de identificación",
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
                                "This score will only be shared with this lender. Your information will not be share with..",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: headingStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // await platform
                                //     .invokeMethod("getSharedText");
                                if (fullName.text.isEmpty) {
                                  Flushbar(
                                    message: "Se requiere nombre y appelidos.",
                                    flushbarPosition: FlushbarPosition.TOP,
                                    duration: Duration(seconds: 3),
                                    leftBarIndicatorColor: walmartBlueInkColor,
                                    onTap: (value) {
                                      // navigatorKey.currentState.push(MaterialPageRoute(
                                      //   builder: (_) => PendingOrderTracking(),

                                      // ));
                                    },
                                  )..show(context);
                                } else if (email.text.isEmpty) {
                                  Flushbar(
                                    message: "Se requiere correo electrónico.",
                                    flushbarPosition: FlushbarPosition.TOP,
                                    duration: Duration(seconds: 3),
                                    leftBarIndicatorColor: walmartBlueInkColor,
                                    onTap: (value) {
                                      // navigatorKey.currentState.push(MaterialPageRoute(
                                      //   builder: (_) => PendingOrderTracking(),

                                      // ));
                                    },
                                  )..show(context);
                                } else if (mobileNo.text.isEmpty) {
                                  Flushbar(
                                    message: "Se requiere número celular.",
                                    flushbarPosition: FlushbarPosition.TOP,
                                    duration: Duration(seconds: 3),
                                    leftBarIndicatorColor: walmartBlueInkColor,
                                    onTap: (value) {
                                      // navigatorKey.currentState.push(MaterialPageRoute(
                                      //   builder: (_) => PendingOrderTracking(),

                                      // ));
                                    },
                                  )..show(context);
                                } else if (govId.text.isEmpty) {
                                  Flushbar(
                                    message:
                                        "Se requiere número de identificación.",
                                    flushbarPosition: FlushbarPosition.TOP,
                                    duration: Duration(seconds: 3),
                                    leftBarIndicatorColor: walmartBlueInkColor,
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
                                      "WLMRT");
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
                                color: walmartBlueInkColor,
                                title: "Enviar",
                                textColor: walmartWhiteColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget heading(title) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .02),
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
                color: walmartBlueColor),
          )
        ],
      ),
    );
  }
}
