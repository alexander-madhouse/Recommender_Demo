import 'package:another_flushbar/flushbar.dart';
import 'package:credoapp_example/helper/basehelper.dart';
import 'package:credoapp_example/utils/colors.dart';
import 'package:credoapp_example/utils/custombutton.dart';
import 'package:credoapp_example/utils/customtextfield.dart';
import 'package:credoapp_example/utils/route.dart';
import 'package:credoapp_example/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  var userId;
  NextScreen({@required this.userId});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NextScreen();
  }
}

class _NextScreen extends State<NextScreen> {
  var width, height;
  bool validate = false;
  TextEditingController user = TextEditingController(text: "cust-kzfl6x1y");
  TextEditingController password = TextEditingController(text: "asd123");
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff062636),
        leading: GestureDetector(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
        ),
        title: Text(
          "Bank Login",
          style: headingStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600, color: mainColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(width * .03),
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/home.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * .85,
                    height: height * .7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .03),
                        color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome To Bank Bot",
                              style: headingStyle.copyWith(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * .04,
                        ),
                        heading("User Name"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              // controller: pass,
                              pass: false, controller: user,
                              width: width * .78,
                              validator: (String value) =>
                                  value.isEmpty ? "Please enter User" : null,
                              title: "Please enter User*",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        heading("Password"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: password,
                              pass: false,
                              width: width * .78,
                              validator: (String value) => value.isEmpty
                                  ? "Please enter password"
                                  : null,
                              title: "Please enter password*",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .06,
                        ),
                        validate == false
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (user.text.isEmpty ||
                                          password.text.isEmpty) {
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
                                        BaseHelper()
                                            .loginUser(
                                                email: user.text,
                                                password: password.text,
                                                userid: this.widget.userId,
                                                context: context)
                                            .then((value) {
                                          //print("authentication response: $value");
                                          BaseHelper().postData(
                                              user_token: value['access_token'],
                                              bearer_token: "",
                                              userId: widget.userId,
                                              context: context);
                                        });
                                        // setState(() {
                                        //   validate = true;
                                        // });
                                      }

                                      // EasyLoading.show();
                                    },
                                    child: CustomButton(
                                      width: width * .8,
                                      height: height * .06,
                                      color: mainColor,
                                      title: "Validate",
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (user.text.isEmpty ||
                                          password.text.isEmpty) {
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
                                        setState(() {
                                          validate = false;
                                        });
                                      }

                                      // EasyLoading.show();
                                    },
                                    child: CustomButton(
                                      width: width * .8,
                                      height: height * .06,
                                      color: mainColor,
                                      title: "Score Me!",
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
