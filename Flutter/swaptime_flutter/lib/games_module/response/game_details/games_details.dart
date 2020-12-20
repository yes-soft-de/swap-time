import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class GameDetailsResponse {
  String statusCode;
  String msg;
  Games data;

  GameDetailsResponse({this.statusCode, this.msg, this.data});

  GameDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Games.fromJson(json['data']) : null;
  }
}
