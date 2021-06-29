import 'package:azumo_challenge/helpers/api_base_helper.dart';
import 'package:flutter/material.dart';

final catGeneratorApi = CatGeneratorApi();

ApiBaseHelper _helper = ApiBaseHelper();

class CatGeneratorApi {
  Future<String> getCat(BuildContext context) async {
    return _helper.baseUrl + '/gif';
  }
}
