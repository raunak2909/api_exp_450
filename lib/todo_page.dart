import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoPage extends StatefulWidget {

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<dynamic> mTodo = [];

  getTodos() async{
    String url = "https://dummyjson.com/todos";
    http.Response mData = await http.get(Uri.parse(url));
    if(mData.statusCode==200){
      print(mData.body);
      dynamic rawData = jsonDecode(mData.body);
      mTodo = rawData["todos"];
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: mTodo.isNotEmpty ? ListView.builder(
        itemCount: mTodo.length,
          itemBuilder: (_, index){
        return CheckboxListTile(
            title: Text(mTodo[index]["todo"]),
            value: mTodo[index]["completed"],
            onChanged: (value){

            });
      }) : Center(child: Text("No Todos found!!")),
    );
  }
}
