import 'package:erp_appp/core/base/base_cubit/base_cubit.dart';
import 'package:erp_appp/core/network/error_handler.dart';
import 'package:erp_appp/data/models/response/info_user_model.dart';
import 'package:erp_appp/data/repositories/authen_repository.dart';
import 'package:erp_appp/di/di.dart';
import 'package:equatable/equatable.dart';

// part 'info_user_state.dart';

// class InfoUserCubit extends Cubit<InfoUserState> {
//   InfoUserCubit() : super(InfoUserInitial());
//   final AuthenRepository _authenRepository = serviceLocator();
//   Future<void> fetchInfoUser() async {
//     try {
//       emit(InfoUserLoading());
//       final infoUser = await _authenRepository.fetchInfoUser();
//       emit(InfoUserLoaded(infoUser));
//     } catch (e) {
//       emit(InfoUserError(e.toString()));
//     }
//   }
// }

class InfoUserCubit extends BaseCubit {
  InfoUserCubit() : super(InitialState());
  final AuthenRepository _authenRepository = serviceLocator();
  Future<void> fetchInfoUser() async {
    try {
      emit(LoadingState());
      final infoUser = await _authenRepository.fetchInfoUser();
      emit(SuccessState<InfoUserModel>(infoUser));
    } catch (error) {
      var errorResponse = ErrorHandler.handle(error).failure;
      emit(FailureState(errorResponse.message));
    }
  }
}
