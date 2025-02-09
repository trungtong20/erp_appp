import 'package:erp_appp/data/models/response/user_model.dart';
import 'package:mysql_db/db/database_service.dart';


sealed class AdminRepository {
  Future<List<UserModel>> fetchUsers();
  Future<void> addUser(String name, String email, String role);
  Future<void> updateUser(String id, String name, String email, String role);
  Future<void> deleteUser(String id);
}

class AdminRepositoryImpl implements AdminRepository {
  final DatabaseService databaseService;

  AdminRepositoryImpl(this.databaseService);

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      final result = await databaseService.getData('users');
      return result.map((row) => UserModel.fromJson(row)).toList();
    } catch (e) {
      print("❌ Error fetching users: $e");
      return [];
    }
  }

  @override
  Future<void> addUser(String name, String email, String role) async {
    try {
      await databaseService.insertData('users', {
        'name': name,
        'email': email,
        'role': role,
      });
      print("✅ User added successfully!");
    } catch (e) {
      print("❌ Error adding user: $e");
    }
  }

  @override
  Future<void> updateUser(
      String id, String name, String email, String role) async {
    try {
      await databaseService.updateData(
        'users',
        {'name': name, 'email': email, 'role': role},
        'id',
        id,
      );
      print("✅ User updated successfully!");
    } catch (e) {
      print("❌ Error updating user: $e");
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await databaseService.deleteData('users', "id = '$id'");
      print("✅ User deleted successfully!");
    } catch (e) {
      print("❌ Error deleting user: $e");
    }
  }
}
