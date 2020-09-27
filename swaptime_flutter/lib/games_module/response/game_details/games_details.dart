class GameDetailsResponse {
  String statusCode;
  String msg;
  GameDetails data;

  GameDetailsResponse({this.statusCode, this.msg, this.data});

  GameDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new GameDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
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
  int commentNumber;
  List<String> comments;
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
