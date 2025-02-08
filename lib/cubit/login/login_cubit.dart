import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_appp/core/constants/app_constants.dart';
import 'package:erp_appp/core/utils/shared_preferences_manager.dart';
import 'package:erp_appp/data/repositories/authen_repository.dart';
import 'package:erp_appp/di/di.dart';
import 'package:erp_appp/router/user_role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginAppState> {
  LoginCubit() : super(LoginAppInitialState());
  final AuthenRepository _authenRepository = serviceLocator();

  final Map<String, Map<String, dynamic>> fakeUsers = {
    'admin': {'password': 'admin123', 'role': UserRole.admin},
    'vendor': {'password': 'vendor123', 'role': UserRole.vendor},
    'user': {'password': 'user123', 'role': UserRole.user},
  };

  void handleLogin({required String email, required String password}) async {
    try {
      emit(LoginInLoadingState());
      // final result = await _authenRepository
      //     .loginApp(LoginRequest(userName: email, passWord: password));
      _handleLoginFakeAccount(email: email, password: password);
      // serviceLocator
      //     .get<SharedPreferencesManager>()
      //     .putString(KeyStorageConstants.jwt, result.token);
      // emit(LoggedInState());
    } on DioExceptionType catch (e) {
      emit(LoginErrorState(error: e.name));
    }
  }

  void _handleLoginFakeAccount(
      {required String email, required String password}) {
    if (fakeUsers.containsKey(email) &&
        fakeUsers[email]!['password'] == password) {
      final userRole = fakeUsers[email]!['role'] as UserRole;

      // Fake token
      const fakeToken = 'fake_jwt_token';

      // Lưu token và role vào SharedPreferences
      final prefs = serviceLocator.get<SharedPreferencesManager>();
      prefs.putString(KeyStorageConstants.jwt, fakeToken);
      prefs.putString(KeyStorageConstants.userRole, userRole.toString());
      emit(LoggedInState(userRole: userRole));
    } else {
      emit(const LoginErrorState(error: "Email or password is incorrect"));
    }
  }
}
