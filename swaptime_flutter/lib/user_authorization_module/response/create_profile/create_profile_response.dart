import 'package:swaptime_flutter/user_authorization_module/request/create_profile/create_profile_body.dart';

class CreateProfileResponse {
  String statusCode;
  String msg;
  CreateProfileBody profileData;

  CreateProfileResponse({this.statusCode, this.msg, this.profileData});

  CreateProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null)
      profileData = CreateProfileBody.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    return data;
  }
}
