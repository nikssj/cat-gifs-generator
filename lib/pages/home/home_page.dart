import 'dart:typed_data';

import 'package:azumo_challenge/helpers/api_base_helper.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String urlGifCat = ApiBaseHelper().baseUrl + '/gif';

  Widget _pic;

  bool isReloading = false;

  @override
  void initState() {
    _getRandomGif();

    super.initState();
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await catGeneratorApi.getCat(context);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Cat GIFs Generator'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Spacer(),

            //Reloading widget
            isReloading
                ? Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: _size.height * 0.05),
                      Text(
                        'Pss pss pss..',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )
                //Cat Gif
                : Card(elevation: 5, child: _pic),

            //Footer button
            Spacer(),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: _size.height * 0.07,
                          bottom: _size.height * 0.04),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildGenerateButton(),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton() {
    final _size = MediaQuery.of(context).size;

    // return GestureDetector(
    //   onTap: () async {
    //     _getRandomGif();
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(10),
    //       ),
    //       color: Colors.blue,
    //     ),
    //     width: 150,
    //     height: 50,
    //     child: Center(
    //         child: Text(
    //       'Press me',
    //       style: TextStyle(color: Colors.white),
    //     )),
    //   ),
    // );

    return TextButton(
      child: Text(
          isReloading
              ? 'Looking for new cats..'.toUpperCase()
              : "Get a new cat!".toUpperCase(),
          style: TextStyle(fontSize: 14, color: Colors.white)),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: _size.width * 0.15, vertical: _size.width * 0.05)),
          backgroundColor: MaterialStateProperty.all<Color>(
              isReloading ? Colors.grey : Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(
              isReloading ? Colors.grey : Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: isReloading ? Colors.grey : Colors.blue)))),
      onPressed: () {
        isReloading ? print('reloading') : _getRandomGif();
      },
    );
  }

  void _getRandomGif() async {
    setState(() {
      isReloading = true;
    });

    Uint8List decodedCatGif = await homeViewModel.getNewCat();

    setState(() {
      _pic = Image.memory(decodedCatGif, fit: BoxFit.cover);
      isReloading = false;
    });
  }
}
