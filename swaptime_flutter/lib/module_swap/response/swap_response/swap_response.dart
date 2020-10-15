class CreateSwapResponse {
  String statusCode;
  String msg;
  Data data;

  CreateSwapResponse({this.statusCode, this.msg, this.data});

  CreateSwapResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int swapItemIdOne;
  int swapItemIdTwo;
  String roomID;
  String status;

  Data({this.swapItemIdOne, this.swapItemIdTwo, this.roomID, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    swapItemIdOne = json['swapItemIdOne'];
    swapItemIdTwo = json['swapItemIdTwo'];
    roomID = json['roomID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['swapItemIdOne'] = this.swapItemIdOne;
    data['swapItemIdTwo'] = this.swapItemIdTwo;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    return data;
  }
}
