import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:erp_appp/ui/screens/vendor/cubit/your_item_page/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewItemPage extends StatefulWidget {
  const AddNewItemPage({super.key});

  @override
  _AddNewItemPageState createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addProduct(BuildContext context) {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    final newProduct = ProductVendorModel(
      id: DateTime.now().toString(),
      name: _nameController.text,
      price: double.parse(_priceController.text),
      imageUrl:
          "https://media.gettyimages.com/id/120170463/photo/series-of-well-lit-crystal-chandeliers.jpg?s=1024x1024&w=gi&k=20&c=v1Zp-WOBSPkhYsTYMoh1nh-QFUnnI1NNqRDEEb79E_0=",
    );

    context.read<ProductCubit>().addProduct(newProduct);

    // Clear inputs
    _nameController.clear();
    _priceController.clear();

    Navigator.of(context).pop(); // Đóng dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully!")),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (contextDialog) => AlertDialog(
        title: const Text("Add New Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Product Price"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => _addProduct(context),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(BuildContext context, ProductVendorModel product) {
    context.read<ProductCubit>().deleteProduct(product.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} removed from the list!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Items"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddProductDialog(context),
              ),
            ],
          ),
          body: state.products.isEmpty
              ? const Center(child: Text("No products added yet."))
              : ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Image.network(
                          product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          "Price: \$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(context, product),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
