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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.games != null) {
      data['games'] = this.games.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  String id;
  String name;
  String category;
  List<String> tag;
  String description;
  String mainImage;
  String userID;
  int commentNumber;
  List<String> comments;
  List<String> images;

  Games(
      {this.id,
      this.name,
      this.category,
      this.tag,
      this.description,
      this.mainImage,
      this.userID,
      this.commentNumber,
      this.comments,
      this.images});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    tag = json['tag'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    userID = json['userID'];
    commentNumber = json['commentNumber'];
    comments = json['comments'].cast<String>();
    images = json['images'].cast<String>();
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
