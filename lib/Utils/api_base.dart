import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:calc/Utils/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../const_widgets/const_dialogs.dart';
import 'app_exception.dart';
import 'connectivity.dart';

class ApiBase {
  /// =================================== GET Method ================================== ///
  Future<dynamic> getApiCall(String url, BuildContext context,
      {isLoading = true}) async {
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    if (isNetActive) {
      if (isLoading) {
        showLoader(context);
      }
      var responseJson;

      Map<String, String> apiHeader = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      print("ApiUrl=========>>>> ${APIConfig.basUrl + url}");
      print("apiHeader=========>>>> $apiHeader");

      try {
        final http.Response response = await http
            .get(
              Uri.parse(APIConfig.basUrl + url),
              headers: apiHeader,
            )
            .timeout(const Duration(seconds: 30))
            .catchError((error) {
          if (isLoading) {
            Navigator.pop(context);
          }
          Fluttertoast.showToast(msg: "Check Internet");
          return Future.error(error);
        });
        if (isLoading) {
          Navigator.pop(context);
        }

        log("statusCode=========>>>> ${response.statusCode}");
        log("response =========>>>> ${response.body}");

        try {
          responseJson = _returnResponse(response);
        } catch (e) {
          if (isLoading) {
            Navigator.pop(context);
          }
        }
      } on SocketException {
        if (isLoading) {
          Navigator.pop(context);
        }
        return "No Internet";
      }
      return responseJson;
    } else {
      Fluttertoast.showToast(msg: "No Internet");
      return "No Internet";
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
