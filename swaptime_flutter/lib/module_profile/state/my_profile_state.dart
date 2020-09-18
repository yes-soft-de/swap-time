class MyProfileState {}

class MyProfileStateInit extends MyProfileState {}

class MyProfileStateUpdateSuccess extends MyProfileState {}

class MyProfileStateCreateSuccess extends MyProfileState {}

class MyProfileStateImageUploadSuccess extends MyProfileState {
  String imageUrl;

  MyProfileStateImageUploadSuccess(this.imageUrl);
}

class MyProfileStateUpdateError extends MyProfileState {}
