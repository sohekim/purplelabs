import 'package:demo/keys.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  // picture keyword
  String keyword;
  // number of pictures I want to show on screen
  int numPics;
  MyHomePage(this.keyword, this.numPics);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List pictureData;

  //parse the Json file
  Future<String> getJson(String keyword, int numPics, String accessKey) async {
    try {
      var response = await http.get(
          'https://api.unsplash.com/search/photos?per_page=${numPics}&client_id=${accessKey}&query=${keyword}');
      setState(() {
        var decode = json.decode(response.body);
        pictureData = decode['results'];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ListView createListView() {
    return new ListView.builder(
      itemCount: pictureData == null ? 0 : pictureData.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Image.network(
            pictureData[index]['urls']['small'],
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getJson(widget.keyword, widget.numPics, unsplash_key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Image ListView',
            style: TextStyle(color: Colors.grey[850]),
          ),
          backgroundColor: Colors.white,
        ),
        body: createListView());
  }
}
