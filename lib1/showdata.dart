import 'package:credoapp_example/utils/route.dart';
import 'package:credoapp_example/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  var data;
  ShowData({@required this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShowData();
  }
}

class _ShowData extends State<ShowData> {
  var width, height;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Data Collected"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .02,
              ),
              showDataa("Score Id", "${widget.data["scoreid"]}"),
              showDataa("Score Value", "${widget.data["scorevalue"]}"),
              showDataa("Reference", "${widget.data["reference"]}"),
              showDataa("Probability", "${widget.data["probability"]}"),
              showDataa("Score Code", "${widget.data["scoreid"]}"),
              showDataa("Offer Code", "${widget.data["offercode"]}"),
              showDataa("User Id", "${widget.data["userid"]}"),
              showDataa("Compaign Id", "${widget.data["campaignid"]}"),
              showDataa("Score Id", "${widget.data["scoreid"]}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDataa(heading, value) {
    return Container(
      margin: EdgeInsets.only(
          bottom: height * .02, left: width * .03, right: width * .03),
      width: width,
      // height: height*.03,
      padding: EdgeInsets.all(width * .03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * .03),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 0.8, spreadRadius: 0.3)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$heading",
                style: headingStyle.copyWith(
                    fontSize: 16,
                    color: Colors.blue[300],
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "$value",
                style: headingStyle.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
