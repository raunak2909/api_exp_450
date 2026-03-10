class UserModel {
  int id;
  String fullName;
  String username;

  UserModel({required this.id, required this.fullName, required this.username});

  ///fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      fullName: json["fullName"],
      username: json["username"],
    );
  }
}

class CommentModel {
  int id;
  int likes;
  int postId;
  String body;
  UserModel user;

  CommentModel({
    required this.id,
    required this.likes,
    required this.postId,
    required this.body,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      likes: json["likes"],
      postId: json["postId"],
      body: json["body"],
      user: UserModel.fromJson(json["user"]),
    );
  }
}

class DataModel {
  int limit;
  int skip;
  int total;
  List<CommentModel> comments;

  DataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.comments,
  });

  factory DataModel.fromJson(Map<String, dynamic> json){

    List<dynamic> jsonComments = json["comments"];
    List<CommentModel> mComments = [];

    /*for (var e in jsonComments) {
      mComments.add(CommentModel.fromJson(e));
    }*/

    for(Map<String, dynamic> eachComment in json["comments"]){
      CommentModel eachCommentModel = CommentModel.fromJson(eachComment);
      mComments.add(eachCommentModel);
    }

    /*for(int i = 0; i<json["comments"].length; i++){
      CommentModel eachCommentModel = CommentModel.fromJson(json["comments"][i]);
      mComments.add(eachCommentModel);
    }*/


    return DataModel(
        limit: json["limit"],
        skip: json["skip"],
        total: json["total"],
        comments: mComments);
  }
}
