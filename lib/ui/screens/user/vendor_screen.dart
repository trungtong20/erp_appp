import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_appp/data/models/response/product_card_model.dart';
import 'package:erp_appp/ui/screens/user/cubit/cart_cubit.dart';
import 'package:erp_appp/ui/screens/user/cubit/product_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  late Map<String, int> _quantities;
  @override
  void initState() {
    super.initState();
    _quantities = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              previous.cartItems != current.cartItems,
          builder: (context, cartState) {
            return BlocBuilder<ProductUserCubit, ProductUserState>(
              buildWhen: (previous, current) =>
                  previous.products != current.products,
              builder: (context, state) {
                final List<ProductCardModel> currentProducts = state.products
                    .map((product) => ProductCardModel(
                          id: product.id,
                          name: product.name,
                          price: product.price,
                          category: "",
                          image: product.imageUrl,
                          quantity: product.quantity,
                        ))
                    .toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: currentProducts.length,
                  itemBuilder: (context, index) {
                    final product = currentProducts[index];

                    // Fix: Call `firstWhere` on `cartState.cartItems`
                    final inCart = cartState.cartItems.firstWhere(
                      (item) => item.id == product.id,
                      orElse: () => product.copyWith(
                          quantity: 0), // Ensure a valid fallback
                    );

                    return ProductCard(
                      product: product,
                      inCartQuantity:
                          _quantities[product.id] ?? inCart.quantity,
                      onAdd: () {
                        context.read<CartCubit>().addProduct(product);
                        setState(() {
                          _quantities[product.id] =
                              (_quantities[product.id] ?? 0) + 1;
                        });
                      },
                      onRemove: () {
                        if ((_quantities[product.id] ?? 0) > 0) {
                          context.read<CartCubit>().removeProduct(product.id);
                          setState(() {
                            _quantities[product.id] =
                                (_quantities[product.id]! - 1)
                                    .clamp(0, double.infinity)
                                    .toInt();
                          });
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductCardModel product;
  final int inCartQuantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCard({
    super.key,
    required this.product,
    required this.inCartQuantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("\$${product.price}",
                    style: const TextStyle(fontSize: 14, color: Colors.green)),
                const SizedBox(height: 5),
                inCartQuantity > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: onRemove,
                          ),
                          Text("$inCartQuantity"),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: onAdd,
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: onAdd,
                        child: const Text("Add to Cart"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
