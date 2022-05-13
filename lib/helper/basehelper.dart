import 'dart:io' as Io;
import 'dart:io';

import 'package:credoapp_example/helper/apinames.dart';
import 'package:credoapp_example/utils/const.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;

class BaseHelper {
  Future<dynamic> loginUser({email, password, context}) async {
    var token = "4373651c-9ba5-3a49-825f-88056e20dc2f";
    var skey = "tVTRDZQCFPee2fcZgSlrpuperfca";
    var secret = "dRYb1KETirsq4fk_bSNEBVHNTfYa";
    var rawStr = JsonUtf8Encoder("$secret");
    print("Raw string: ${rawStr}");
    final plainText = "${skey}";
    var sh = sha1.convert(utf8.encode(skey + ':' + secret));
    var bytes = utf8.encode(sh.toString());
    var dataaa = base64.encode(bytes);
    print("SH data: ${dataaa}");

    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print("encrypted: ${encrypted.base64}");

    var header = {
      // "content-Type": "application/x-www-form-urlencoded",
      "content-type": "application/x-www-form-urlencoded",
      "User-Agent": "PostmanRuntime/7.29.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      // "Authorization": "Basic $dataaa",
      "Authorization":
          "Basic dFZUUkRaUUNGUGVlMmZjWmdTbHJwdXBlcmZjYTpkUlliMUtFVGlyc3E0ZmtfYlNORUJWSE5UZllh",
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
      print("urlll: $url");
      EasyLoading.show();
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);

      var Json = json.decode(response.body);
      print("response data: ${Json}");
      print("response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return Json;
      } else {
        EasyLoading.dismiss();
        toast("Incorrect email or password!", context);
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
