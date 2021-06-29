import 'dart:typed_data';

import 'package:azumo_challenge/apis/cat_generator_api.dart';
import 'package:azumo_challenge/helpers/api_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    _updateImgWidget();

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
        isReloading ? print('reloading') : _updateImgWidget();
      },
    );
  }

  void _updateImgWidget() async {
    setState(() {
      isReloading = true;
    });

    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(urlGifCat +
                '?v=' +
                DateTime.now().millisecondsSinceEpoch.toString()))
            .load(urlGifCat))
        .buffer
        .asUint8List();

    setState(() {
      _pic = Image.memory(bytes, fit: BoxFit.cover);
      isReloading = false;
    });
  }
}
