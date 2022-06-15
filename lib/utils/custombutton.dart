import 'package:credoapp_example/utils/styles.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomButton extends StatefulWidget {
  var width, height, title, textColor;
  Color color;
  CustomButton(
      {required this.color,
      this.height,
      this.title,
      this.width,
      this.textColor});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return custom();
  }
}

class custom extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: widget.color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * .03),
      ),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .03),
            color: widget.color,
            border: Border.all(color: walmartBlueInkColor)),
        child: Center(
          child: Text(
            "${widget.title}",
            style: headingStyle.copyWith(
                color: widget.textColor, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
