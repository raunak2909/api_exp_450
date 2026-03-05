import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> mData = [];

  getQuotes() async {
    String url = "https://dummyjson.com/quotes";

    var response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      mData = rawData["quotes"];
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: mData.isNotEmpty
          ? ListView.builder(
        itemCount: mData.length,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                title: Text(mData[index]["quote"]),
                subtitle: Text(mData[index]["author"]),
              ),
            );
      })
          : Center(child: Text("No Quotes found!!")),
    );
  }
}
