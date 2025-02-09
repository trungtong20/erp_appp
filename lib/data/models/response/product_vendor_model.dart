class ProductVendorModel {
  String id;
  String name;
  double price;
  String imageUrl;
  int quantity;

  ProductVendorModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}
