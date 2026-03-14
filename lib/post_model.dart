class ReactionModel {
  int likes;
  int dislikes;

  ReactionModel({required this.likes, required this.dislikes});

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(likes: json["likes"], dislikes: json["dislikes"]);
  }
}

class PostModel {
  String body;
  int id;
  String title;
  int userId;
  int views;
  ReactionModel reactions;
  List<dynamic> tags;

  PostModel({
    required this.body,
    required this.id,
    required this.title,
    required this.userId,
    required this.views,
    required this.reactions,
    required this.tags,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      body: json["body"],
      id: json["id"],
      title: json["title"],
      userId: json["userId"],
      views: json["views"],
      reactions: ReactionModel.fromJson(json["reactions"]),
      tags: json["tags"],
    );
  }
}

class DataModel {
  int limit;
  int skip;
  int total;
  List<PostModel> posts;

  DataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.posts,
  });

  factory DataModel.fromJson(Map<String, dynamic> json){

    List<PostModel> mPosts = [];

    for(Map<String, dynamic> eachMap in json["posts"]){
      mPosts.add(PostModel.fromJson(eachMap));
    }

    return DataModel(
        limit: json["limit"],
        skip: json["skip"],
        total: json["total"],
        posts: mPosts);
  }
}
