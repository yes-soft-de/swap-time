class ImgBBResponse {
  Data data;
  bool success;
  int status;

  ImgBBResponse({this.data, this.success, this.status});

  ImgBBResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String id;
  String title;
  String urlViewer;
  String url;
  String displayUrl;
  String size;
  String time;
  String expiration;
  Image image;
  Image thumb;
  Image medium;
  String deleteUrl;

  Data(
      {this.id,
      this.title,
      this.urlViewer,
      this.url,
      this.displayUrl,
      this.size,
      this.time,
      this.expiration,
      this.image,
      this.thumb,
      this.medium,
      this.deleteUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlViewer = json['url_viewer'];
    url = json['url'];
    displayUrl = json['display_url'];
    size = json['size'].toString();
    time = json['time'];
    expiration = json['expiration'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    thumb = json['thumb'] != null ? new Image.fromJson(json['thumb']) : null;
    medium = json['medium'] != null ? new Image.fromJson(json['medium']) : null;
    deleteUrl = json['delete_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['url_viewer'] = this.urlViewer;
    data['url'] = this.url;
    data['display_url'] = this.displayUrl;
    data['size'] = this.size;
    data['time'] = this.time;
    data['expiration'] = this.expiration;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.thumb != null) {
      data['thumb'] = this.thumb.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    data['delete_url'] = this.deleteUrl;
    return data;
  }
}

class Image {
  String filename;
  String name;
  String mime;
  String extension;
  String url;

  Image({this.filename, this.name, this.mime, this.extension, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    name = json['name'];
    mime = json['mime'];
    extension = json['extension'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = this.filename;
    data['name'] = this.name;
    data['mime'] = this.mime;
    data['extension'] = this.extension;
    data['url'] = this.url;
    return data;
  }
}
