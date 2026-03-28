part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final String errorText;
  const AuthState({this.status = AuthStatus.initial, this.errorText = ""});

  @override
  List<Object> get props => [];
}

enum AuthStatus { error, initial, loading, authentificated }

void qoshish({required int son1, int son2 = 5}) {
  // * body
}
