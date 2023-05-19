import 'package:demo1/model/RatingModel.dart';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? category;
  String? description;
  String? image;
  RatingModel? rating;
  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image,
      this.rating});
  factory ProductModel.fromJson(Map<String, dynamic> obj) {
    return ProductModel(
        id: obj['id'],
        title: obj['title'],
        price: obj['price'],
        category: obj['category'],
        description: obj['description'],
        image: obj['image'],
        rating: RatingModel.fromJson(obj['rating']));
  }
}
