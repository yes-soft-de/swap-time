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
  List<int> gamesAllowedUserOne;
  List<int> gamesAllowedUserTwo;

  SwapListItem({
    this.id,
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
    this.status,
    this.gamesAllowedUserOne,
    this.gamesAllowedUserTwo,
  });

  SwapListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    userIdOne = json['userIdOne'];
    userOneName = json['userOneName'];
    userTwoName = json['userTwoName'];
    swapItemIdOne = json['swapItemIdOne'];
    swapItemIdTwo = json['swapItemIdTwo'];
    userIdTwo = json['userIdTwo'];

    userOneImage = json['userOneImage'];
    userOneImage = userOneImage.substring(userOneImage.lastIndexOf('http'));

    userTwoImage = json['userTwoImage'];
    userTwoImage = userTwoImage.substring(userTwoImage.lastIndexOf('http'));

    swapItemOneImage = json['swapItemOneImage'];
    swapItemOneImage =
        swapItemOneImage.substring(swapItemOneImage.lastIndexOf('http'));

    swapItemTwoImage = json['swapItemTwoImage'];
    swapItemTwoImage =
        swapItemTwoImage.substring(swapItemTwoImage.lastIndexOf('http'));

    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
    if (json['gamesAllowedUserOne'] != null) {
      gamesAllowedUserOne = json['gamesAllowedUserOne'].cast<int>();
    }
    if (json['gamesAllowedUserTwo'] != null) {
      gamesAllowedUserTwo = json['gamesAllowedUserTwo'].cast<int>();
    }
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
    data['gamesAllowedUserOne'] = this.gamesAllowedUserOne;
    data['gamesAllowedUserTwo'] = this.gamesAllowedUserTwo;
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
