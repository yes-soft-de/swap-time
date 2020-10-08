class SwapItemCreateRequest {
  String name;
  String category;
  List<String> tag;
  String description;
  String mainImage;
  String userID;

  SwapItemCreateRequest(
      {this.name,
      this.category,
      this.tag,
      this.description,
      this.mainImage,
      this.userID});

  SwapItemCreateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    tag = json['tag'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['category'] = this.category;
    data['tag'] = this.tag;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;
    data['userID'] = this.userID;
    return data;
  }
}
