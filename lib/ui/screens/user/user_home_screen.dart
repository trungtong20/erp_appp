import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:erp_appp/ui/screens/user/cart_screen.dart';
import 'package:erp_appp/ui/screens/user/cubit/cart_cubit.dart';
import 'package:erp_appp/ui/screens/user/vendor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'guest_list_screen.dart';
import 'order_status_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    super.key,
  });

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const VendorScreen(),
    CartScreen(),
    OrderStatusScreen(),
    GuestListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome User"),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Call the logout method, passing the current context
              context.read<AuthCubit>().logout();
            },
          ),
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              backgroundColor: Colors.black,
              label: "Vendor",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              backgroundColor: Colors.black,
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              backgroundColor: Colors.black,
              label: "Order Status",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              backgroundColor: Colors.black,
              label: "Guest List",
            ),
          ],
        ),
      ),
    );
  }
}
