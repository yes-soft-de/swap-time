class ProfileModel {
  String name;
  String image;
  String story;

  ProfileModel({this.name, this.image, this.story});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    story = json['story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    data['story'] = this.story;
    return data;
  }
}
