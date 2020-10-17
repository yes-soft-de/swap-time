import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

class ProfileListResponse {
  String statusCode;
  String msg;
  List<ProfileResponse> data;

  ProfileListResponse({this.statusCode, this.msg, this.data});

  ProfileListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = <ProfileResponse>[];
        json['data'].forEach((v) {
          data.add(new ProfileResponse.fromJson(v));
        });
      } else {
        data = [new ProfileResponse.fromJson(json['data'])];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
