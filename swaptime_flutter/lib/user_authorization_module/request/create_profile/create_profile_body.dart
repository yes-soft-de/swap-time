class CreateProfileBody {
  String userID;
  List<String> roles;
  String name;
  String sex;
  String nationality;
  String guideLanguage;
  String arrivalCity;
  String arrivalDate;
  String stayDays;
  List<String> interests;
  String email;
  String phoneNumber;
  String image;
  CreateDate createDate;

  CreateProfileBody(
      {this.userID,
        this.roles,
        this.name,
        this.sex,
        this.nationality,
        this.guideLanguage,
        this.arrivalCity,
        this.arrivalDate,
        this.stayDays,
        this.interests,
        this.email,
        this.phoneNumber,
        this.image,
        this.createDate});

  CreateProfileBody.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    roles = json['roles'].cast<String>();
    name = json['name'];
    sex = json['sex'];
    nationality = json['nationality'];
    guideLanguage = json['guideLanguage'];
    arrivalCity = json['arrivalCity'];
    arrivalDate = json['arrivalDate'];
    stayDays = json['stayDays'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];

    interests = [];
    if (json['interests'] != null) {
      json['interests'].forEach((interest) {
        interests.add(interest);
      });
    }

    createDate = json['createDate'] != null
        ? new CreateDate.fromJson(json['createDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['roles'] = this.roles;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['nationality'] = this.nationality;
    data['guideLanguage'] = this.guideLanguage;
    data['arrivalCity'] = this.arrivalCity;
    data['arrivalDate'] = this.arrivalDate;
    data['stayDays'] = this.stayDays;
    data['interests'] = this.interests;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['image'] = this.image;
    if (this.createDate != null) {
      data['createDate'] = this.createDate.toJson();
    }
    return data;
  }
}

class CreateDate {
  Timezone timezone;
  int offset;
  int timestamp;

  CreateDate({this.timezone, this.offset, this.timestamp});

  CreateDate.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = new List<Transitions>();
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}
