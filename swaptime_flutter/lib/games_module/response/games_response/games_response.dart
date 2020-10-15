import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class GamesResponse {
  List<Games> games;

  GamesResponse({this.games});

  GamesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      games = <Games>[];
      json['data'].forEach((v) {
        games.add(new Games.fromJson(v));
      });
    }
  }
}

class Games {
  int id;
  String name;
  String category;
  String platform;
  List<String> tag;
  String description;
  String mainImage;
  String userID;
  String userName;
  String commentNumber;
  Interaction interaction;
  List<CommentModel> comments;
  List<String> images;
  bool specialLink;

  Games(
      {this.id,
      this.name,
      this.category,
      this.platform,
      this.tag,
      this.description,
      this.mainImage,
      this.userID,
      this.userName,
      this.commentNumber,
      this.interaction,
      this.comments,
      this.images,
      this.specialLink});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    platform = json['platform'];
    tag = json['tag'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    userID = json['userID'];
    userName = json['userName'];
    commentNumber = json['commentNumber'];
    interaction = json['interaction'] != null
        ? new Interaction.fromJson(json['interaction'])
        : null;
    comments = json['comments'];
    images = json['images'].cast<String>();
    specialLink = json['specialLink'];
  }
}

class Interaction {
  String loved;
  bool checkLoved;

  Interaction({this.loved, this.checkLoved});

  Interaction.fromJson(Map<String, dynamic> json) {
    loved = json['loved'];
    checkLoved = json['checkLoved'];
  }
}
