class ProfileResponse {
  int id;
  String userID;
  String userName;
  String location;
  String story;
  String image;
  int likes;
  int views;
  int games;

  ProfileResponse({
    this.id,
    this.userID,
    this.userName,
    this.games,
    this.location,
    this.story,
    this.image,
    this.views,
    this.likes,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    userName = json['userName'];
    location = json['location'];
    story = json['story'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['location'] = this.location;
    data['story'] = this.story;
    data['image'] = this.image;
    return data;
  }
}
