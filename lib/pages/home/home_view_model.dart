import 'dart:typed_data';

import 'package:azumo_challenge/apis/cat_generator_api.dart';

import 'models/cat_model.dart';

final homeViewModel = HomeViewModel();

class HomeViewModel {
  //Class where you put setState methods. Make api calls. Play with widget data.
  //Implement business logic here.

  Cat _cat = new Cat();

  Cat get cat => _cat;

  set setDecodedGif(Uint8List value) {
    cat.decodedGif = value;
  }

  Future getNewCat() async {
    final Uint8List response = await catGeneratorApi.getDecodedGif();

    if (response != null) {
      setDecodedGif = response;
    }
  }
}
