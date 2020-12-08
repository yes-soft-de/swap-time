class ReportRequest {
  String userID;
  String swapItemID;
  String date = DateTime.now().toIso8601String();

  ReportRequest({this.userID, this.swapItemID, this.date});

  ReportRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    swapItemID = json['swapItemID'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    data['date'] = this.date;
    return data;
  }
}
