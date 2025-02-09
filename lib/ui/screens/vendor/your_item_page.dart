import 'package:erp_appp/ui/screens/vendor/cubit/your_item_page/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourItemsPage extends StatelessWidget {
  const YourItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YourItemsView();
  }
}

class YourItemsView extends StatelessWidget {
  const YourItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Items"),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return const Center(child: Text("No products added yet."));
          }
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    onPressed: () {
                      context.read<ProductCubit>().deleteProduct(product.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
