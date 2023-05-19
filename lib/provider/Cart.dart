import 'package:demo1/model/CartItemModel.dart';
import 'package:demo1/model/ProductModel.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> list = [];

  CartItemModel? getItemByProduct(ProductModel product) {
    for (var item in list) {
      if (item.product.id == product.id) {
        return item;
      }
    }
    return null;
  }

  double calculateTotal() {
    double totalPrice = 0;
    for (var item in list) {
      totalPrice += item.quantity * item.product.price!;
    }
    return totalPrice;
  }

  void addNewProduct(ProductModel product, int quantity) {
    CartItemModel? cartItem = getItemByProduct(product);
    if (cartItem == null) {
      list.add(CartItemModel(product, quantity));
    } else {
      var idx = list.indexOf(cartItem);
      list[idx].quantity += quantity;
    }
    notifyListeners();
  }

  void updateItemQuantity(CartItemModel cartItem, bool increase) {
    var idx = list.indexOf(cartItem);
    if (list[idx].quantity <= 1 && !increase) {
      return;
    }
    list[idx].quantity += increase ? 1 : -1;
    notifyListeners();
  }

  void deleteProduct(CartItemModel cartItem) {
    list.remove(cartItem);
    notifyListeners();
  }
}
