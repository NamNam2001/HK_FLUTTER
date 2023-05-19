import 'package:demo1/model/CartItemModel.dart';
import 'package:demo1/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color primaryColor = Color.fromARGB(255, 255, 89, 0);

class CartItem extends StatefulWidget {
  final CartItemModel item;

  const CartItem({required this.item, Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final defaultImage =
      'https://deconova.eu/wp-content/uploads/2016/02/default-placeholder.png';

  void updateItemQuantity(bool increase) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.updateItemQuantity(widget.item, increase);
  }

  void deleteItem() {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.deleteProduct(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.item.product.image ?? defaultImage),
                        fit: BoxFit.fill))),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.item.product.title ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.item.product.category ?? "",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(100, 0, 0, 0)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            deleteItem();
                          },
                          icon: Icon(Icons.delete_outline))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$ ${widget.item.product.price.toString()}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(20, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updateItemQuantity(false);
                                },
                                icon: Icon(Icons.remove)),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.item.quantity.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                                onPressed: () {
                                  updateItemQuantity(true);
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
