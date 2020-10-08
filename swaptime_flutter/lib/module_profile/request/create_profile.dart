class CreateProfileRequest {
  String userName;
  String userID;
  String story;
  String image;
  String location;

  CreateProfileRequest({
    this.userID,
    this.story,
    this.userName,
    this.location,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': this.userID,
      'userName': this.userName,
      'story': this.story,
      'location': this.location,
      'image': this.image,
    };
  }
}
