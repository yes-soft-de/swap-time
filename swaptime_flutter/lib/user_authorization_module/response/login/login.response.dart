class LoginResponse {
  String _token;

  LoginResponse(Map<String, dynamic> jsonPayload) {
    _token = jsonPayload['token'];
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}