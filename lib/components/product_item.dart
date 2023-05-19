import 'package:demo1/model/ProductModel.dart';
import 'package:demo1/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color primaryColor = Color.fromARGB(255, 255, 89, 0);

class ProductItem extends StatelessWidget {
  final ProductModel item;
  final defaultImage =
      'https://deconova.eu/wp-content/uploads/2016/02/default-placeholder.png';
  final bool gridView;

  const ProductItem({required this.item, required this.gridView, Key? key})
      : super(key: key);

  void switchToDetailPage(BuildContext context) {
    Navigator.pushNamed(context, '/product', arguments: item);
  }

  void addToCart(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addNewProduct(item, 1);
  }

  @override
  Widget build(BuildContext context) {
    return gridView ? buildGrid(context) : buildList(context);
  }

  buildGrid(BuildContext context) {
    return InkWell(
      onTap: () {
        switchToDetailPage(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Center(
                      child: Container(
                        width: constraints.maxWidth * 2 / 3,
                        height: constraints.maxWidth * 2 / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(item.image ?? defaultImage),
                                fit: BoxFit.fill)),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    item.title ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    item.description ?? "",
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(100, 0, 0, 0)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "\$ ${item.price.toString()}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addToCart(context);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: primaryColor)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: primaryColor,
                        size: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildList(BuildContext context) {
    return InkWell(
      onTap: () {
        switchToDetailPage(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          image: NetworkImage(item.image ?? defaultImage),
                          fit: BoxFit.fill))),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          item.title ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          item.description ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(100, 0, 0, 0)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                size: 16,
                                color: i < item.rating!.rate!.toInt()
                                    ? Colors.red
                                    : Color.fromARGB(100, 0, 0, 0),
                              ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${item.rating!.count.toString()} lượt xem",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(100, 0, 0, 0)),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "\$ ${item.price.toString()}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addToCart(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: primaryColor)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.white),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: primaryColor,
                            size: 16,
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
      ),
    );
  }
}
