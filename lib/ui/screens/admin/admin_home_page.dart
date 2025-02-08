import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'maintain_user_page.dart';
import 'maintain_vendor_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0; // Index for the selected tab

  // Pages corresponding to bottom navigation items
  final List<Widget> _pages = [
    const Center(child: Text("Welcome Admin", style: TextStyle(fontSize: 24))),
    MaintainUserPage(),
    MaintainVendorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            // Call the logout method, passing the current context
            context.read<AuthCubit>().logout();
          },
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Maintain User",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Maintain Vendor",
          ),
        ],
      ),
    );
  }
}
