import 'package:erp_appp/core/constants/app_constants.dart';
import 'package:erp_appp/core/utils/shared_preferences_manager.dart';
import 'package:erp_appp/di/di.dart';
import 'package:erp_appp/router/user_role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  void login(UserRole role) {
    serviceLocator
        .get<SharedPreferencesManager>()
        .putString(KeyStorageConstants.userRole, role.toString());
    emit(state.copyWith(isLogin: true, userRole: role));
  }

  void logout() {
    final prefs = serviceLocator.get<SharedPreferencesManager>();
    prefs.remove(KeyStorageConstants.jwt);
    prefs.remove(KeyStorageConstants.userRole);
    emit(AuthState());
  }

  void checkLogin() async {
    // final isExpired = await checkExpiredToken();
    // const isExpired = true;
    // if (isExpired) {
    //   final roleString = serviceLocator
    //           .get<SharedPreferencesManager>()
    //           .getString(KeyStorageConstants.userRole) ??
    //       'unknown';

    //   final role = UserRole.values.firstWhere(
    //     (e) => e.toString() == roleString,
    //     orElse: () => UserRole.user,
    //   );

    //   emit(AuthState(isLogin: true, userRole: role));
    // }
    emit(AuthState(isLogin: false));
  }

  Future<bool> checkExpiredToken() async {
    final accessToken = serviceLocator
            .get<SharedPreferencesManager>()
            .getString(KeyStorageConstants.jwt) ??
        '';
    return accessToken.isNotEmpty;
  }
}
