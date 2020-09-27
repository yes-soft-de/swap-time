class AuthState {}

class AuthStateSuccess extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateCodeSent extends AuthState {}

class AuthStateError extends AuthState {
  String errorMsg;
  AuthStateError(this.errorMsg);
}

class AuthStateInit extends AuthState {}
