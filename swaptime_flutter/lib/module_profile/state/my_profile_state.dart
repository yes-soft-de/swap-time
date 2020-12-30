import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

class MyProfileState {}

class MyProfileStateInit extends MyProfileState {}

class MyProfileStateUpdateSuccess extends MyProfileState {}

class MyProfileStateCreateSuccess extends MyProfileState {}

class MyProfileStateGetSuccess extends MyProfileState {
  final ProfileResponse profile;
  MyProfileStateGetSuccess(this.profile);
}

class MyProfileStateLoading extends MyProfileState {}

class MyProfileStateImageUploadSuccess extends MyProfileState {
  String imageUrl;

  MyProfileStateImageUploadSuccess(this.imageUrl);
}

class MyProfileStateUpdateError extends MyProfileState {
  String err;
  MyProfileStateUpdateError(err);
}
