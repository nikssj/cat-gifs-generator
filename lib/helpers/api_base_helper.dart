// Dart imports:
import 'dart:async';
import 'dart:io';

import 'package:azumo_challenge/config/api_configuration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  String baseUrl = ApiConfiguration.URL_DEVELOP;

  Future get(String url, BuildContext context) async {
    http.Response response;

    try {
      response = await http
          .get(
            Uri.parse(baseUrl + url),
          )
          .timeout(Duration(seconds: 30));
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Timeout get');
    } catch (e) {
      throw (e);
    }
    return response;
  }
}
