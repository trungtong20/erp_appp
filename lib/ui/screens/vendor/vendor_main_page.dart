import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:erp_appp/ui/screens/vendor/add_new_item_page.dart';
import 'package:erp_appp/ui/screens/vendor/cubit/your_item_page/product_cubit.dart';
import 'package:erp_appp/ui/screens/vendor/your_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'add_new_item_page.dart'; // Create this file for "Add New Item" logic
import 'transaction_page.dart'; // Create this file for "Transaction" logic
// import 'your_item_page.dart'; // Create this file for "Your Item" logic

class VendorMainPage extends StatefulWidget {
  const VendorMainPage({super.key});

  @override
  _VendorMainPageState createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  int _currentIndex = 0;

  // Pages for each bottom navigation tab
  final List<Widget> _pages = [
    const YourItemsPage(), // "Your Item" page
    const AddNewItemPage(), // "Add New Item" page
    TransactionPage(), // "Transaction" page
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome, Vendor"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                // Call the logout method, passing the current context
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
        body: _pages[
            _currentIndex], // Dynamically switch pages based on selected tab
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update selected index
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              backgroundColor: Colors.black,
              label: "Your Items",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              backgroundColor: Colors.black,
              label: "Add Item",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              backgroundColor: Colors.black,
              label: "Transaction",
            ),
          ],
        ),
      ),
    );
  }
}
