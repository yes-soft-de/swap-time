class ItemCreateRequest {
  String name;
  String platform;
  List<String> tags;
  String description;
  String mainImage;
  bool specialLink = true;
  String userID;
  String category = 'Games';

  ItemCreateRequest(
      {this.name,
      this.platform,
      this.tags,
      this.description,
      this.mainImage,
      this.specialLink,
      this.userID,
      this.category});

  ItemCreateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    platform = json['platform'];
    tags = json['tags'].cast<String>();
    description = json['description'];
    mainImage = json['mainImage'];
    specialLink = json['specialLink'];
    userID = json['userID'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['platform'] = this.platform;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;
    data['specialLink'] = this.specialLink;
    data['userID'] = this.userID;
    data['category'] = this.category;
    return data;
  }
}
