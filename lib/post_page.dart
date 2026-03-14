import 'dart:convert';

import 'package:api_exp_450/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<List<PostModel>> getPosts() async {
    String url = "https://dummyjson.com/posts";

    http.Response res = await http.get(Uri.parse(url));
    List<PostModel> mPosts = [];
    if (res.statusCode == 200) {
      dynamic rawData = jsonDecode(res.body);
      DataModel dataModel = DataModel.fromJson(rawData);
      mPosts = dataModel.posts;
      return mPosts;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder<List<PostModel>>(
        future: getPosts(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snap.hasData) {
            List<PostModel> mPosts = snap.data!;
            return mPosts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            title: Text(mPosts[index].title),
                            subtitle: Text(
                              mPosts[index].body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      mPosts[index].reactions.likes.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_down_alt_outlined,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      mPosts[index].reactions.dislikes
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: Text('No post yet!!'));
          }

          if(snap.hasError){
            return Center(
              child: Text('Error: ${snap.error}'),
            );
          }

          return Container();
        },
      ),
    );
  }
}
