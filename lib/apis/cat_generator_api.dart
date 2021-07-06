import 'dart:typed_data';

import 'package:azumo_challenge/helpers/api_base_helper.dart';
import 'package:flutter/services.dart';

final catGeneratorApi = CatGeneratorApi();

class CatGeneratorApi {
  Future<Uint8List> getDecodedGif() async {
    //GIF in Uint8List format Function

    final url = ApiBaseHelper().baseUrl + '/gif';

    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(
                url + '?v=' + DateTime.now().millisecondsSinceEpoch.toString()))
            .load(url))
        .buffer
        .asUint8List();

    return bytes;
  }
}
