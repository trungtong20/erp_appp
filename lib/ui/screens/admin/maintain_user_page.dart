import 'package:erp_appp/data/models/response/user_model.dart';
import 'package:erp_appp/ui/screens/admin/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintainUserPage extends StatelessWidget {
  MaintainUserPage({super.key});
  final UserCubit userCubit = UserCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userCubit..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Maintain Users"),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.users.isEmpty) {
              return const Center(child: Text("No users available"));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text("${user.email} - ${user.role}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editUser(context, user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(context, user.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addUser(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _addUser(BuildContext context) async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String? selectedRole = "user";

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            DropdownButtonFormField<String>(
              value: selectedRole,
              onChanged: (value) => selectedRole = value,
              items: ["admin", "user", "vendor"].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty || emailController.text.isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(content: Text("All fields are required!")),
                );
                return;
              }
              Navigator.of(dialogContext).pop({
                "name": nameController.text,
                "email": emailController.text,
                "role": selectedRole!,
              });
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );

    if (result != null) {
      userCubit.addUser(result["name"]!, result["email"]!, result["role"]!);
    }
  }

 Future<void> _editUser(BuildContext context, UserModel user) async {
  final nameController = TextEditingController(text: user.name);
  final emailController = TextEditingController(text: user.email);
  String? selectedRole = user.role;

  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text("Edit User"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          DropdownButtonFormField<String>(
            value: selectedRole,
            onChanged: (value) => selectedRole = value,
            items: ["admin", "user", "vendor"].map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            decoration: const InputDecoration(labelText: "Role"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isEmpty || emailController.text.isEmpty) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(content: Text("All fields are required!")),
              );
              return;
            }
            Navigator.of(dialogContext).pop({
              "name": nameController.text,
              "email": emailController.text,
              "role": selectedRole!,
            });
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );

  if (result != null) {
    userCubit.updateUser(
          user.id,
          result["name"]!,
          result["email"]!,
          result["role"]!,
        );
  }
}


  void _deleteUser(BuildContext context, String userId) {
    userCubit.deleteUser(userId);
  }
}
