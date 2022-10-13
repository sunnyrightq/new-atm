import 'dart:convert';
import 'dart:io';

import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/shared_preferences.dart';
import 'package:atm/utils/show_logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  static String endPointUrl = APIEndpoints.baseUrl + APIEndpoints.hostUrl;

  static Future<Map<String, String>> _getHeaders() async {
    final String? token = await LocalStorage.getString(key: AppConstant.token);
    if (token != null) {
      showLogs(message: "TOKEN -- 'Bearer $token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      };
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, String>> _getMultipartHeaders() async {
    final String? token = await LocalStorage.getString(key: AppConstant.token);
    if (token != null) {
      showLogs(message: "TOKEN -- 'Bearer $token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      };
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<APIResponse> getMethod({required String url}) async {
    var header = await _getHeaders();
    showLogs(message: "GET URL -- '$endPointUrl$url'");
    http.Response response = await http.get(
      Uri.parse("$endPointUrl$url"),
      headers: header,
    );
    showLogs(message: "GET RESPONSE CODE -- '${response.statusCode}'");
    showLogs(message: "GET RESPONSE -- '${response.body}'");
    if ((json.decode(response.body)["status"] == null
            ? response.statusCode
            : json.decode(response.body)["status"].toString().toLowerCase()) ==
        "ok") {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: true, statusCode: response.statusCode, data: response.body);
      return data;
    } else {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: false, statusCode: response.statusCode, data: response.body);
      return data;
    }
  }

  static Future<APIResponse> postMethod(
      {required BuildContext context, required String url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    showLogs(message: "POST URL -- '$endPointUrl$url'");
    showLogs(message: "POST DATA -- '$data'");
    http.Response response = await http.post(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    showLogs(message: "POST RESPONSE CODE -- '${response.statusCode}'");
    showLogs(message: "POST RESPONSE -- '${response.body}'");

    print(
        "TEST ::${(json.decode(response.body)["status"] == null ? response.statusCode.toString().toLowerCase() : json.decode(response.body)["status"].toString().toLowerCase()) == "error"} || ${(json.decode(response.body)["message"] == null ? response.statusCode.toString().toLowerCase() : json.decode(response.body)["message"].toString().toLowerCase()) == "invalid auth key!"}");
    if ((json.decode(response.body)["status"] == null
                ? response.statusCode.toString().toLowerCase()
                : json.decode(response.body)["status"].toString().toLowerCase()) ==
            "error" &&
        (json.decode(response.body)["message"] == null
                ? response.statusCode.toString().toLowerCase()
                : json.decode(response.body)["message"].toString().toLowerCase()) ==
            "invalid auth key!") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Center(child: Text("Logout", style: TextStyle(color: Colors.red))),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: const Text("Your session is expire.\nPlease re-login to continue.",
                  style: TextStyle(), textAlign: TextAlign.center),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await LocalStorage.clearStorage();
                      PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Okay!",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            );
          });
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: false, statusCode: response.statusCode, data: response.body);
      return data;
    } else if ((json.decode(response.body)["status"] == null
            ? response.statusCode
            : json.decode(response.body)["status"].toString().toLowerCase()) ==
        "ok") {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: true, statusCode: response.statusCode, data: response.body);
      return data;
    } else {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: false, statusCode: response.statusCode, data: response.body);
      return data;
    }
  }

  static Future<APIResponse> putMethod({required String url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    showLogs(message: "PUT URL -- '$endPointUrl$url'");
    showLogs(message: "PUT DATA -- '$data'");
    http.Response response = await http.put(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    showLogs(message: "PUT RESPONSE CODE -- '${response.statusCode}'");
    showLogs(message: "PUT RESPONSE -- '${response.body}'");

    if ((json.decode(response.body)["status"] == null
            ? response.statusCode
            : json.decode(response.body)["status"].toString().toLowerCase()) ==
        "ok") {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: true, statusCode: response.statusCode, data: response.body);
      return data;
    } else {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: false, statusCode: response.statusCode, data: response.body);
      return data;
    }
  }

  static Future<APIResponse> deleteMethod({required String url}) async {
    var header = await _getHeaders();
    showLogs(message: "DELETE URL -- '$endPointUrl$url'");
    http.Response response = await http.delete(
      Uri.parse("$endPointUrl$url"),
      headers: header,
    );
    showLogs(message: "DELETE RESPONSE CODE -- '${response.statusCode}'");
    showLogs(message: "DELETE RESPONSE -- '${response.body}'");
    if ((json.decode(response.body)["status"] == null
            ? response.statusCode
            : json.decode(response.body)["status"].toString().toLowerCase()) ==
        "ok") {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: true, statusCode: response.statusCode, data: response.body);
      return data;
    } else {
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: false, statusCode: response.statusCode, data: response.body);
      return data;
    }
  }

  static Future<APIResponse> postMultiPartRequestMethod({
    required String url,
    required Map<String, String> data,
    File? file1Data,
    String? file1Key,
    File? file2Data,
    String? file2Key,
    File? file3Data,
    String? file3Key,
  }) async {
    var request = http.MultipartRequest("POST", Uri.parse("$endPointUrl$url"));
    request.fields.addAll(data);
    request.headers.addAll(await _getMultipartHeaders());
    if (file1Data != null && file1Key != null) {
      request.files.add(await http.MultipartFile.fromPath(file1Key, file1Data.path));
    }if (file2Data != null && file2Key != null) {
      request.files.add(await http.MultipartFile.fromPath(file2Key, file2Data.path));
    }
    if (file3Data != null && file3Key != null) {
      request.files.add(await http.MultipartFile.fromPath(file3Key, file3Data.path));
    }
    showLogs(message: "STREAM URL -- ${request.url}");
    showLogs(message: "STREAM HEADERS -- ${request.headers}");
    showLogs(message: "STREAM FIELDS -- ${request.fields}");
    http.StreamedResponse response = await request.send();
    showLogs(message: "STREAM RESPONSE -- ${response.statusCode}");
    http.Response responsed = await http.Response.fromStream(response);
    if ((json.decode(responsed.body)["status"] == null
            ? response.statusCode
            : json.decode(responsed.body)["status"].toString().toLowerCase()) ==
        "ok") {
      showLogs(message: "This is response code 200");

      showLogs(message: "RESPONSED -- ${json.decode(responsed.body)}");
      APIResponse data =
          APIResponse(header: response.headers, isSuccess: true, statusCode: response.statusCode, data: responsed.body);
      return data;
    } else {
      showLogs(message: "This is else part");
      showLogs(message: "RESPONSED ELSE -- ${json.decode(responsed.body)}");
      APIResponse data = APIResponse(
          header: response.headers, isSuccess: false, statusCode: response.statusCode, data: responsed.body);
      return data;
    }
  }
}
