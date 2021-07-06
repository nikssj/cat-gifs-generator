import 'dart:typed_data';

import 'package:azumo_challenge/apis/cat_generator_api.dart';

final homeViewModel = HomeViewModel();

class HomeViewModel {
  //Class where you put setState methods. Make api calls. Play with widget data.
  //Implement business logic here.

  Future getNewCat() async {
    Uint8List decodedGif = await catGeneratorApi.getDecodedGif();

    return decodedGif;
  }
}
