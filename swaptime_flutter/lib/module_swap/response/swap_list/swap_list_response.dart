class SwapListResponse {
  String statusCode;
  String msg;
  List<SwapListItem> data;

  SwapListResponse({this.statusCode, this.msg, this.data});

  SwapListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SwapListItem>[];
      json['data'].forEach((v) {
        data.add(new SwapListItem.fromJson(v));
      });
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

class SwapListItem {
  int id;
  Date date;
  String userIdOne;
  String userOneName;
  String userOneImage;
  String userTwoName;
  String userTwoImage;
  String userIdTwo;
  int swapItemIdOne;
  String swapItemOneImage;
  int swapItemIdTwo;
  String swapItemTwoImage;
  String cost;
  String roomID;
  String status;

  SwapListItem(
      {this.id,
      this.date,
      this.userIdOne,
      this.userOneName,
      this.userOneImage,
      this.userTwoName,
      this.userTwoImage,
      this.userIdTwo,
      this.swapItemIdOne,
      this.swapItemOneImage,
      this.swapItemIdTwo,
      this.swapItemTwoImage,
      this.cost,
      this.roomID,
      this.status});

  SwapListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    userIdOne = json['userIdOne'];
    userOneName = json['userOneName'];
    userOneImage = json['userOneImage'];
    userTwoName = json['userTwoName'];
    userTwoImage = json['userTwoImage'];
    userIdTwo = json['userIdTwo'];
    swapItemIdOne = json['swapItemIdOne'];
    swapItemOneImage = json['swapItemOneImage'];
    swapItemIdTwo = json['swapItemIdTwo'];
    swapItemTwoImage = json['swapItemTwoImage'];
    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['userIdOne'] = this.userIdOne;
    data['userOneName'] = this.userOneName;
    data['userOneImage'] = this.userOneImage;
    data['userTwoName'] = this.userTwoName;
    data['userTwoImage'] = this.userTwoImage;
    data['userIdTwo'] = this.userIdTwo;
    data['swapItemIdOne'] = this.swapItemIdOne;
    data['swapItemOneImage'] = this.swapItemOneImage;
    data['swapItemIdTwo'] = this.swapItemIdTwo;
    data['swapItemTwoImage'] = this.swapItemTwoImage;
    data['cost'] = this.cost;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    return data;
  }
}

class Date {
  int timestamp;

  Date({this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = this.timestamp;
    return data;
  }
}
