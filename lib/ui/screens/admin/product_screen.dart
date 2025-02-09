import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_appp/data/models/response/product_card_model.dart';
import 'package:erp_appp/ui/screens/admin/cubit/product_admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
            child: BlocBuilder<ProductAdminCubit, ProductAdminState>(
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

                    return ProductCard(
                      product: product,
                    );
                  },
                );
              },
            )));
  }
}

class ProductCard extends StatelessWidget {
  final ProductCardModel product;

  const ProductCard({
    super.key,
    required this.product,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
