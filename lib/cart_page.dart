import 'package:demo1/components/app_bar.dart';
import 'package:demo1/components/cart_item.dart';
import 'package:demo1/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(isHomepage: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Giỏ hàng",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("${cartProvider.list.length.toString()} Sản phẩm"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(50, 0, 0, 0)))),
                      )
                    ]),
              ),
              cartProvider.list.isEmpty
                  ? const Center(
                      child: Text(
                      "Bạn chưa có sản phẩm nào trong giỏ hàng",
                      style: TextStyle(fontSize: 20),
                    ))
                  : Container(),
              Expanded(
                  child: ListView(
                children: [
                  ...cartProvider.list.map((e) {
                    return CartItem(
                      item: e,
                    );
                  }).toList(),
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: cartProvider.list.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng tiền",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "\$ ${cartProvider.calculateTotal().toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: cartProvider.list.isNotEmpty
                    ? Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side:
                                        const BorderSide(color: primaryColor)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                backgroundColor: Colors.white),
                            child: const Icon(
                              Icons.message_outlined,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: primaryColor)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  backgroundColor: primaryColor),
                              child: const Text(
                                "Thanh toán",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        ));
  }
}
