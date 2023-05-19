import 'dart:convert';
import 'package:demo1/model/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list = [];

  void getList(String category, String searchValue, String filter) async {
    String apiUrl;
    if (category == "") {
      apiUrl = "https://fakestoreapi.com/products";
    } else {
      apiUrl = "https://fakestoreapi.com/products/category/${category}";
    }
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiUrl));
    List<dynamic> productListObject = jsonDecode(jsonString.body);
    list = productListObject.map((e) {
      return ProductModel.fromJson(e);
    }).toList();
    search(searchValue);
    filterProduct(filter);
    notifyListeners();
  }

  void search(String searchValue) async {
    List newList = [];
    for (var product in list) {
      if (product.title!.toUpperCase().contains(searchValue.toUpperCase())) {
        newList.add(product);
      }
    }
    list = List.from(newList);
  }

  void filterProduct(String filter) async {
    switch (filter) {
      case "A-Z":
        list.sort((a, b) {
          return a.title!.compareTo(b.title!);
        });
        break;
      case "Z-A":
        list.sort((a, b) {
          return b.title!.compareTo(a.title!);
        });
        break;
      case "Giá thấp":
        list.sort((a, b) {
          return a.price!.compareTo(b.price!);
        });
        break;
      case "Giá cao":
        list.sort((a, b) {
          return b.price!.compareTo(a.price!);
        });
        break;
    }
  }
}
