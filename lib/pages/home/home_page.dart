import 'dart:math';

import 'package:azumo_challenge/apis/cat_generator_api.dart';
import 'package:azumo_challenge/helpers/api_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await catGeneratorApi.getCat(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    String imageUrl;
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
              child: FadeInImage(
                  key: ValueKey(new Random().nextInt(100)),
                  image: NetworkImage(
                      imageUrl ?? ApiBaseHelper().baseUrl + '/gif'),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  height: _size.width * 0.7,
                  fit: BoxFit.fill),
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
                print(imageUrl);

                setState(() {
                  imageUrl = ApiBaseHelper().baseUrl +
                      '/gif' +
                      '?v=${DateTime.now().millisecondsSinceEpoch}';
                  imageCache.clear();
                  imageCache.clearLiveImages();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
