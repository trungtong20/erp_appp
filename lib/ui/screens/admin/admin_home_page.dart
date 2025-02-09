import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:erp_appp/ui/screens/admin/cubit/product_admin_cubit.dart';
import 'package:erp_appp/ui/screens/admin/product_screen.dart';
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
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text("Welcome Admin", style: TextStyle(fontSize: 24))),
    MaintainUserPage(),
    MaintainVendorPage(),
    const ProductScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductAdminCubit()..fetchProducts(),
      child: Scaffold(
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
          backgroundColor:
              Colors.blueGrey[900],
          selectedItemColor: Colors.orangeAccent, 
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true, 
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
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_sharp),
              label: "Products",
            ),
          ],
        ),
      ),
    );
  }
}
