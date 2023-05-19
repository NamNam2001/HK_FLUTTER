import 'package:demo1/components/app_bar.dart';
import 'package:demo1/model/ProductModel.dart';
import 'package:demo1/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

const Color primaryColor = Color.fromARGB(255, 255, 89, 0);

class ProductItempage extends StatefulWidget {
  final ProductModel item;

  const ProductItempage({required this.item, Key? key}) : super(key: key);

  @override
  State<ProductItempage> createState() => _ProductItempageState();
}

class _ProductItempageState extends State<ProductItempage> {
  final defaultImage =
      'https://deconova.eu/wp-content/uploads/2016/02/default-placeholder.png';
  int quantity = 1;
  int currentPos = 0;

  void updateQuantity(bool increase) {
    if (quantity <= 1 && !increase) {
      return;
    }
    setState(() {
      quantity += increase ? 1 : -1;
    });
  }

  void addToCart(int quantity) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addNewProduct(widget.item, quantity);
    Navigator.pushNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        isHomepage: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: [
                    for (var i = 0; i < 5; i++)
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Center(
                            child: Container(
                              width: constraints.maxWidth * 3 / 4,
                              height: constraints.maxWidth * 3 / 4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.item.image ?? defaultImage),
                                      fit: BoxFit.fill)),
                            ),
                          );
                        }),
                      ),
                  ],
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPos = index;
                        });
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2, 3, 4].map((e) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPos == e
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.item.category ?? "",
                          style: const TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 30,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              widget.item.rating!.rate!.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "(${widget.item.rating!.count!.toString()} đánh giá)",
                              style: const TextStyle(
                                  color: Color.fromARGB(100, 0, 0, 0)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  Text(
                    "\$ ${widget.item.price.toString()}",
                    style: const TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color.fromARGB(50, 0, 0, 0)))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Mô tả",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(widget.item.description ?? "",
                  style: const TextStyle(fontSize: 18, height: 1.6)),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Số lượng",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(20, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              updateQuantity(false);
                            },
                            icon: Icon(Icons.remove)),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              updateQuantity(true);
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: primaryColor)),
                        padding: const EdgeInsets.symmetric(vertical: 24),
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
                      onPressed: () {
                        addToCart(quantity);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: primaryColor)),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          backgroundColor: primaryColor),
                      child: const Text(
                        "Thêm vào giỏ hàng",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
