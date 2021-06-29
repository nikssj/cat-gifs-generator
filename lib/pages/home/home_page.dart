import 'dart:math';
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
  String url = ApiBaseHelper().baseUrl + '/gif';

  Widget _pic;

  @override
  void initState() {
    _pic = Image.network(url);
    super.initState();
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await catGeneratorApi.getCat(context);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat GIFs Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: _pic,
            ),
            SizedBox(height: _size.height * 0.1),
            TextButton(
              child: Text("Generate!".toUpperCase(),
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: _size.width * 0.15,
                          vertical: _size.width * 0.05)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)))),
              onPressed: () {
                _updateImgWidget();
              },
            )
          ],
        ),
      ),
    );
  }

  _updateImgWidget() async {
    setState(() {
      _pic = CircularProgressIndicator();
    });
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    setState(() {
      _pic = Image.memory(bytes);
    });
  }
}
