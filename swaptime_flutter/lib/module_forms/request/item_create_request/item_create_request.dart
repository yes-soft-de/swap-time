class ItemCreateRequest {
  String name;
  List<String> tag;
  String description;
  String mainImage;
  String userID;

  ItemCreateRequest(
      {this.name, this.tag, this.description, this.mainImage, this.userID});

  ItemCreateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tag = json['tag'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;
    data['userID'] = this.userID;
    return data;
  }
}
