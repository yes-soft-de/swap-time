import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_report/repository/report_repository/report_repository.dart';
import 'package:swaptime_flutter/module_report/request/report_request.dart';

@provide
class ReportManager {
  ReportRepository _repository;

  void postReport(ReportRequest reportRequest) =>
      _repository.postReport(reportRequest);
}
