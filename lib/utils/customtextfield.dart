import 'package:credoapp_example/utils/styles.dart';
import 'package:credoapp_example/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  var width, height, title;
  bool keyboardTypenumeric, number;
  bool pass = false;
  var validation;
  final Function validator;
  TextEditingController controller = TextEditingController();
  CustomTextField(
      {required this.height,
      required this.validator,
      required this.number,
      required this.keyboardTypenumeric,
      required this.pass,
      required this.controller,
      required this.title,
      required this.width});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return custom();
  }
}

class custom extends State<CustomTextField> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: widget.width,
      height: widget.width * .18,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .02),
          border: Border.all(color: Colors.white),
          color: Colors.grey[200]),
      // padding: ,
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: widget.controller,
        validator: widget.validation,
        keyboardType: widget.keyboardTypenumeric == true
            ? TextInputType.number
            : TextInputType.text,

        // maxLength: widget.number == true ? 8 : 40,
        style: labelTextStyle.copyWith(
            // color: secondaryColor,
            fontSize: 16,
            color: walmartBlueInkColor,
            fontWeight: FontWeight.normal),
        obscureText: widget.pass == true
            ? show == false
                ? true
                : false
            : false,

        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(widget.width * .05),
            counterText: "",
            hintText: "${widget.title}",
            // prefixIcon: widget.pass == true
            //     ? Icon(
            //         Icons.lock,
            //         size: widget.height * .005,
            //       )
            //     : Icon(
            //         Icons.person,
            //         size: widget.height * .005,
            //       ),
            // suffixIcon: widget.pass == true
            //     ? GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             show = !show;
            //           });
            //         },
            //         child: Icon(
            //           show == false ? Icons.visibility_off : Icons.visibility,
            //           size: 20,
            //         ),
            //       )
            //     : GestureDetector(
            //         onTap: () {
            //           widget.controller.clear();
            //         },
            //         child: Icon(
            //           Icons.close,
            //           size: 20,
            //         ),
            //       ),

            // labelText: "${widget.title}",
            hintStyle: labelTextStyle.copyWith(
                color: walmartBlueInkColor,
                fontSize: 14,
                fontWeight: FontWeight.normal)),
      ),
    );
  }
}
