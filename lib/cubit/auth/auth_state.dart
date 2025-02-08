part of 'auth_cubit.dart';


class AuthState {
  final bool isLogin;
  final UserRole userRole;

  AuthState({this.isLogin = false, this.userRole = UserRole.user});

  AuthState copyWith({bool? isLogin, UserRole? userRole}) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      userRole: userRole ?? this.userRole,
    );
  }
}
