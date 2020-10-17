class ByImageState {}

class ByImageStateInit extends ByImageState {}

class ByImageStateUploadSuccess extends ByImageState {
  String imageUrl;

  ByImageStateUploadSuccess(this.imageUrl);
}

class ByImageStateUploadError extends ByImageState {
  String errorMsg;

  ByImageStateUploadError(this.errorMsg);
}

class ByImageStatePostSuccess extends ByImageState {}

class ByImageStatePostError extends ByImageState {
  String errorMsg;

  ByImageStatePostError(this.errorMsg);
}
