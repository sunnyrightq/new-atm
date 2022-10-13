import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apiservice with ChangeNotifier {
  final url = "https://atm.alphapixclients.com/";

  Future<Map<String, dynamic>> signup(Map<String, dynamic> param) async {
    try {
      print(param);
      Response res = await post(Uri.parse(url + "ajaxfiles/create_user.php"), body: param);
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        return json;
      } else {
        throw Exception(res);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> Login_page(Map<String, dynamic> param) async {
    try {
      print(param);
      Response res = await post(Uri.parse(url + "ajaxfiles/login_check.php"), body: param);
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        return json;
      } else {
        throw Exception(res);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
