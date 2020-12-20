class ProfileModel {
  String name;
  String image;

  ProfileModel({this.name, this.image});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
