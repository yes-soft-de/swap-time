class CreateSwapRequest {
  String userIdOne;
  String userIdTwo;
  int swapItemIdOne;
  int swapItemIdTwo;
  String roomID;
  String date;

  CreateSwapRequest(
      {this.userIdOne,
      this.userIdTwo,
      this.swapItemIdOne,
      this.swapItemIdTwo,
      this.roomID,
      this.date});

  CreateSwapRequest.fromJson(Map<String, dynamic> json) {
    userIdOne = json['userIdOne'];
    userIdTwo = json['userIdTwo'];
    swapItemIdOne = json['swapItemIdOne'];
    swapItemIdTwo = json['swapItemIdTwo'];
    roomID = json['roomID'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userIdOne'] = this.userIdOne;
    data['userIdTwo'] = this.userIdTwo;
    data['swapItemIdOne'] = this.swapItemIdOne;
    data['swapItemIdTwo'] = this.swapItemIdTwo;
    data['roomID'] = this.roomID;
    data['date'] = this.date;
    return data;
  }
}
