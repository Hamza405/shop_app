class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModel({this.id, this.title, this.description, this.price, this.imageUrl});
}