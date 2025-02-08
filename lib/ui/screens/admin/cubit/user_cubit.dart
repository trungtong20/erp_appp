import 'package:equatable/equatable.dart';
import 'package:erp_appp/data/models/response/user_model.dart';
import 'package:erp_appp/data/repositories/admin_repository.dart';
import 'package:erp_appp/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AdminRepository adminRepository = serviceLocator.get<AdminRepository>();

  UserCubit() : super(const UserState());

  Future<void> fetchUsers() async {
    if (isClosed) return;
    try {
      emit(state.copyWith(isLoading: true));
      final users = await adminRepository.fetchUsers();
      if (!isClosed) emit(state.copyWith(users: users, isLoading: false));
    } catch (e) {
      print("❌ Error fetching users: $e");
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> addUser(String name, String email, String role) async {
    try {
      await adminRepository.addUser(name, email, role);
      final newUser = UserModel(
        id: DateTime.now().toString(),
        name: name,
        email: email,
        role: role,
      );
      emit(state.copyWith(users: [...state.users, newUser]));
    } catch (e) {
      print("❌ Error adding user: $e");
    }
  }

  Future<void> updateUser(
      String id, String name, String email, String role) async {
    try {
      await adminRepository.updateUser(id, name, email, role);
      final updatedUsers = state.users.map((user) {
        return user.id == id
            ? UserModel(id: id, name: name, email: email, role: role)
            : user;
      }).toList();
      emit(state.copyWith(users: updatedUsers));
    } catch (e) {
      print("❌ Error updating user: $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await adminRepository.deleteUser(id);
      final updatedUsers = state.users.where((user) => user.id != id).toList();
      emit(state.copyWith(users: updatedUsers));
    } catch (e) {
      print("❌ Error deleting user: $e");
    }
  }
}


// class UserCubit extends Cubit<UserState> {
//   UserCubit() : super(const UserState());

//   Future<void> fetchUsers() async {
//     emit(state.copyWith(isLoading: true));
//     await Future.delayed(const Duration(seconds: 1));
//     final dummyUsers = [
//       const UserModel(
//           id: "1", name: "John Doe", email: "john@example.com", role: "admin"),
//       const UserModel(
//           id: "2", name: "Jane Smith", email: "jane@example.com", role: "user"),
//     ];
//     emit(state.copyWith(users: dummyUsers, isLoading: false));
//   }

//   Future<void> addUser(String name, String email, String role) async {
//     final newUser = UserModel(
//         id: DateTime.now().toString(), name: name, email: email, role: role);
//     emit(state.copyWith(users: [...state.users, newUser]));
//   }

//   Future<void> updateUser(
//       String id, String name, String email, String role) async {
//     final updatedUsers = state.users.map((user) {
//       return user.id == id
//           ? UserModel(id: id, name: name, email: email, role: role)
//           : user;
//     }).toList();
//     emit(state.copyWith(users: updatedUsers));
//   }

//   Future<void> deleteUser(String id) async {
//     final updatedUsers = state.users.where((user) => user.id != id).toList();
//     emit(state.copyWith(users: updatedUsers));
//   }
// }
