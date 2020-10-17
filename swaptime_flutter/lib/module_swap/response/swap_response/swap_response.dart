class CreateSwapResponse {
  String statusCode;
  String msg;
  SwapItemModel data;

  CreateSwapResponse({this.statusCode, this.msg, this.data});

  CreateSwapResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data =
        json['data'] != null ? new SwapItemModel.fromJson(json['data']) : null;
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

class SwapItemModel {
  int swapItemIdOne;
  int swapItemIdTwo;
  String roomID;
  String status;

  SwapItemModel(
      {this.swapItemIdOne, this.swapItemIdTwo, this.roomID, this.status});

  SwapItemModel.fromJson(Map<String, dynamic> json) {
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
