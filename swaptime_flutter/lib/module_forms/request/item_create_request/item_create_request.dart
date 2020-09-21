class ItemCreateRequest {
  String name;
  String description;
  String category;
  String mainImage;
  String userID;
  List<String> tag;

  ItemCreateRequest(
      {this.name,
      this.description,
      this.category,
      this.mainImage,
      this.userID,
      this.tag});

  ItemCreateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    category = json['category'];
    mainImage = json['mainImage'];
    userID = json['userID'];
    tag = json['tag'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['mainImage'] = this.mainImage;
    data['userID'] = this.userID;
    data['tag'] = this.tag;
    return data;
  }
}
