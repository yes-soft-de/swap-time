class SwapListResponse {
  String statusCode;
  String msg;
  List<Data> data;

  SwapListResponse({this.statusCode, this.msg, this.data});

  SwapListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String userIdOne;
  String userIdTwo;
  int swapItemIdOne;
  int swapItemIdTwo;
  Null cost;
  String roomID;
  Null status;

  Data(
      {this.id,
      this.userIdOne,
      this.userIdTwo,
      this.swapItemIdOne,
      this.swapItemIdTwo,
      this.cost,
      this.roomID,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userIdOne = json['userIdOne'];
    userIdTwo = json['userIdTwo'];
    swapItemIdOne = json['swapItemIdOne'];
    swapItemIdTwo = json['swapItemIdTwo'];
    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userIdOne'] = this.userIdOne;
    data['userIdTwo'] = this.userIdTwo;
    data['swapItemIdOne'] = this.swapItemIdOne;
    data['swapItemIdTwo'] = this.swapItemIdTwo;
    data['cost'] = this.cost;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    return data;
  }
}
