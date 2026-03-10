import 'dart:convert';

import 'package:api_exp_450/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  DataModel? mData;

  getComments() async{
    String url = "https://dummyjson.com/comments";
    http.Response res = await http.get(Uri.parse(url));
    if(res.statusCode==200){
      dynamic rawData = jsonDecode(res.body);
      mData = DataModel.fromJson(rawData);
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: mData != null ? mData!.comments.isNotEmpty ? ListView.builder(itemBuilder: (_, index){
        return ListTile(
          title: Text(mData!.comments[index].body),
          subtitle: Text(mData!.comments[index].user.username),
        );
      }) : Center(child: Text("No Comments found!!")) : Center(child: CircularProgressIndicator()),
    );
  }
}
