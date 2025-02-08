import 'package:erp_appp/data/models/response/credential_model.dart';
import 'package:erp_appp/data/models/response/info_user_model.dart';
import 'package:erp_appp/data/models/request/login_request.dart';
import 'package:erp_appp/data/service/authen_service.dart';

sealed class AuthenRepository {
  Future<CredentialModel> loginApp(LoginRequest request);
  Future<InfoUserModel> fetchInfoUser();
}

class AuthenRepositoryImpl extends AuthenRepository {
  final AuthenService authenService;
  AuthenRepositoryImpl({required this.authenService});
  @override
  Future<CredentialModel> loginApp(LoginRequest request) async {
    return await authenService.loginApp(request);
  }

  @override
  Future<InfoUserModel> fetchInfoUser() async {
    return await authenService.fetchInfoUser();
  }
}
