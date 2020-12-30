class UpdateSwapRequest {
  String id;
  String date;
  String userIdOne;
  String userIdTwo;
  int swapItemIdOne;
  int swapItemIdTwo;
  int cost;
  String status;
  String roomID;

  UpdateSwapRequest(
      {this.id,
      this.date,
      this.userIdOne,
      this.userIdTwo,
      this.swapItemIdOne,
      this.swapItemIdTwo,
      this.cost,
      this.status,
      this.roomID});

  UpdateSwapRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userIdOne = json['userIdOne'];
    userIdTwo = json['userIdTwo'];
    swapItemIdOne = json['swapItemIdOne'];
    status = json['status'];
    swapItemIdTwo = json['swapItemIdTwo'];
    cost = json['cost'];
    roomID = json['roomID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['date'] = this.date.substring(0, 10);
    data['userIdOne'] = this.userIdOne;
    data['userIdTwo'] = this.userIdTwo;
    data['swapItemIdOne'] = this.swapItemIdOne;
    data['swapItemIdTwo'] = this.swapItemIdTwo;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['roomID'] = this.roomID;
    return data;
  }
}
