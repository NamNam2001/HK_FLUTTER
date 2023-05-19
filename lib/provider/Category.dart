import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> list = [];
  void getList() async {
    String apiUrl = "https://fakestoreapi.com/products/categories";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiUrl));
    List<dynamic> categoryListObject = jsonDecode(jsonString.body);
    list = categoryListObject.map((e) {
      return e.toString();
    }).toList();
    notifyListeners();
  }
}
