import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_forms/response/rawg_search/rawg_response.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class RawGRepository {
  final ApiClient _client;

  RawGRepository(this._client);

  Future<RawGResponse> search(String searchQuery) async {
    Map<String, String> params = {
      'search': searchQuery,
    };
    Map<String, dynamic> response =
        await _client.get(Urls.SEARCH_GAMES_API, queryParams: params);

    if (response == null) {
      return null;
    }
    return RawGResponse.fromJson(response);
  }
}
