import 'dart:io' as Io;
import 'dart:io';

import 'package:credoapp_example/helper/apinames.dart';
import 'package:credoapp_example/main.dart';
import 'package:credoapp_example/utils/const.dart';
import 'package:credoapp_example/utils/route.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;

class BaseHelper {
  Future<dynamic> loginUser({email, password, userid, context}) async {
    var token = "4373651c-9ba5-3a49-825f-88056e20dc2f";
    var skey = "tVTRDZQCFPee2fcZgSlrpuperfca";
    var secret = "dRYb1KETirsq4fk_bSNEBVHNTfYa";
    var credentials = skey + ':' + secret;
    // var rawStr = JsonUtf8Encoder(credentials);
    // print("Raw string: ${rawStr}");
    // final plainText = "${skey}";
    // var sh = sha1.convert(utf8.encode(credentials));
    // var bytes = utf8.encode(sh.toString());
    // var dataaa = base64.encode(bytes);

    var basic_token = base64.encode(utf8.encode(credentials));
    print("basic_token = ${basic_token}");
    // print("SH data: ${dataaa}");

    // final key = Key.fromSecureRandom(32);
    // final iv = IV.fromSecureRandom(16);
    // final encrypter = Encrypter(AES(key));

    // final encrypted = encrypter.encrypt(plainText, iv: iv);
    // print("encrypted: ${encrypted.base64}");

    var header = {
      // "content-Type": "application/x-www-form-urlencoded",
      "content-type": "application/x-www-form-urlencoded",
      //"User-Agent": "PostmanRuntime/7.29.0",
      //"Accept": "*/*",
      //"Accept-Encoding": "gzip, deflate, br",
      //"Connection": "keep-alive",
      // "Authorization": "Basic $dataaa",
      "Authorization": "Basic " + basic_token,
      // "x-powered-by": "ASP.NET"
      // "Accept": "application/json",
    };
    try {
      var body = "grant_type=client_credentials";
      // json.encode({
      //   "grant_type": "client_credentials",
      //   // "password": "$password",
      //   // "grant_type": "password"
      // });
      print("body: $body");
      print("header $header");
      var url = "${API.authentication}";
      print("url: $url");
      EasyLoading.show();
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);

      var Json = json.decode(response.body);
      print("response data: ${Json}");
      print("response status code: ${response.statusCode}");
      if (response.statusCode != 200) {
        EasyLoading.dismiss();
        toast("Incorrect email or password!", context);
        return;
      }

      var token_bearer = Json['access_token'];

      print("access_token: ${token_bearer}");

      var tunlAuthURL =
          "https://api.4wrd.tech:8243/authorize/2.0/token?provider=AB4WRD";

      print("Logging in to TUNL:  " + tunlAuthURL);
      // var data = json.encode({
      //   "grant_type": "password",
      //   "username": "cust-kzfl6x1y",
      //   "password": "asd123",
      // });
      // var header2 = {
      //   "content-type": "application/x-www-form-urlencoded",
      //   "Authorization": "Bearer ${token_bearer}",
      // };

      // print("data: $data");
      // print("header2 $header2");
      // final response2 =
      //     await http.post(Uri.parse(url), headers: header2, body: data);

      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${token_bearer}'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://api.4wrd.tech:8243/authorize/2.0/token?provider=AB4WRD'));
      request.bodyFields = {
        'grant_type': 'password',
        'username': 'cust-kzfl6x1y',
        'password': 'asd123'
      };
      request.headers.addAll(headers);

      http.StreamedResponse response2 = await request.send();

      if (response2.statusCode == 200) {
        var bodyResponse = await response2.stream.bytesToString();
        print(bodyResponse);
        var Json2 = json.decode(bodyResponse);
        print("response2 data: ${Json2}");
        EasyLoading.dismiss();
        return Json2;
      } else {
        print(response2.reasonPhrase);
        EasyLoading.dismiss();
        toast("Incorrect email or password!", context);
        return;
      }
    } on SocketException {
      toast("No Internet", context);
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);

      toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      toast("${value}", context);
      EasyLoading.dismiss();
      print("${value}");
    }
  }

  Future<dynamic> postData({userId, bearer_token, user_token, context}) async {
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    try {
      var body = jsonEncode({
        "bearer_token": "$bearer_token",
        "user_token": "$user_token",
        "userid": "$userId"
      });
      // json.encode({
      //   "grant_type": "client_credentials",
      //   // "password": "$password",
      //   // "grant_type": "password"
      // });
      print("body: $body");
      print("header $header");
      var url = "${API.dataPost}";
      print("url: $url");
      EasyLoading.show();
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);

      // var Json = json.decode(response.body);
      // print("response data: ${Json}");
      print("response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        AppRoutes.makeFirst(context, MyHomePage());
        toast("Data Saved Successfully!", context);
      } else {
        EasyLoading.dismiss();
        toast("Server error!", context);
      }
    } on SocketException {
      toast("No Internet", context);
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);

      toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      toast("${value}", context);
      EasyLoading.dismiss();
      print("${value}");
    }
  }
}

// class AuthResponse {
//   String access_token;
//   String scope;
//   String token_type;
//   int expires_in;

//   AuthResponse(
//       {this.access_token = '',
//       this.scope = '',
//       this.token_type = '',
//       this.expires_in = 0});

//   AuthResponse.fromJson(Map<String, dynamic> json) {
//     access_token = json['access_token'];
//   }
// }
