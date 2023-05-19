import 'dart:js';

import 'package:demo1/cart_page.dart';
import 'package:demo1/model/ProductModel.dart';
import 'package:demo1/product_item_page.dart';
import 'package:demo1/products_page.dart';
import 'package:demo1/provider/Cart.dart';
import 'package:demo1/provider/Category.dart';
import 'package:demo1/provider/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: ProductsPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => ProductsPage(),
          '/cart': (context) => CartPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product') {
            final args = settings.arguments as ProductModel;

            return MaterialPageRoute(
              builder: (context) {
                return ProductItempage(
                  item: args,
                );
              },
            );
          }
        },
      )));
}
