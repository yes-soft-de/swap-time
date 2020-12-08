import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';
import 'package:swaptime_flutter/module_report/request/report_request.dart';

@provide
class ReportRepository {
  final ApiClient _client;
  ReportRepository(this._client);

  void postReport(ReportRequest reportRequest) {
    // Report and don't wait the result
    _client.post(Urls.API_REPORT, reportRequest.toJson());
  }
}
