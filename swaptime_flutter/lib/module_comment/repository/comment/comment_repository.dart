import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_comment/request/create_comment/create_comment.dart';
import 'package:swaptime_flutter/module_comment/response/comment/create_comment_response.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class CommentRepository {
  final ApiClient _apiClient;
  CommentRepository(this._apiClient);

  Future<CreateCommentResponse> createComment(
      CreateCommentRequest commentRequest) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.API_COMMENTS, commentRequest.toJson());

    return response != null ? CreateCommentResponse.fromJson(response) : null;
  }
}
