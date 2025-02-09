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

  final Map<String, UserRole> fakeUsers = {
    'admin': UserRole.admin,
    'vendor': UserRole.vendor,
    'user': UserRole.user,
  };

  void handleLogin({required String email, required String password}) async {
    try {
      emit(LoginInLoadingState());

      _handleLoginFakeAccount(email: email);

      // final result = await _authenRepository.loginApp(LoginRequest(userName: email));
      // serviceLocator.get<SharedPreferencesManager>().putString(KeyStorageConstants.jwt, result.token);
      // emit(LoggedInState());
    } on DioExceptionType catch (e) {
      emit(LoginErrorState(error: e.name));
    }
  }

  void _handleLoginFakeAccount({required String email}) {
    final normalizedEmail = email.toLowerCase();

    String? matchedKey;
    UserRole? matchedRole;

    for (var entry in fakeUsers.entries) {
      if (normalizedEmail.contains(entry.key)) {
        matchedKey = entry.key;
        matchedRole = entry.value;
        break;
      }
    }

    if (matchedRole != null) {
      // Fake token
      const fakeToken = 'fake_jwt_token';

      final prefs = serviceLocator.get<SharedPreferencesManager>();
      prefs.putString(KeyStorageConstants.jwt, fakeToken);
      prefs.putString(KeyStorageConstants.userRole, matchedRole.toString());

      emit(LoggedInState(userRole: matchedRole));
    } else {
      emit(const LoginErrorState(error: "Username is incorrect"));
    }
  }
}
