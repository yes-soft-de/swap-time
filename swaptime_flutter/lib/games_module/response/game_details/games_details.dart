import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class GameDetailsResponse {
  String statusCode;
  String msg;
  Games data;

  GameDetailsResponse({this.statusCode, this.msg, this.data});

  GameDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Games.fromJson(json['data']) : null;
  }
}

class GameDetails {
  int id;
  String name;
  String category;
  List<String> tag;
  String description;
  String mainImage;
  String userID;
  String commentNumber;
  List<CommentModel> comments;
  List<String> images;

  GameDetails({
    this.id,
    this.name,
    this.category,
    this.tag,
    this.description,
    this.mainImage,
    this.userID,
    this.commentNumber,
    this.comments,
    this.images,
  });

  GameDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    tag = json['tag'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    userID = json['userID'];
    commentNumber = json['commentNumber'] ?? '0';
    comments = json['comments'] != null ? json['comments'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['tag'] = this.tag;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;
    data['userID'] = this.userID;
    data['commentNumber'] = this.commentNumber;
    data['comments'] = this.comments;
    data['images'] = this.images;
    return data;
  }
}
