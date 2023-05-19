import 'package:demo1/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomepage;
  final void Function()? toggleSearch;

  const CustomAppBar({required this.isHomepage, this.toggleSearch, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return AppBar(
      title: Center(child: Text("SHOPEEFAKE")),
      backgroundColor: Color.fromARGB(255, 255, 89, 0),
      leading: IconButton(
        icon:
            isHomepage ? const Icon(Icons.menu) : const Icon(Icons.arrow_back),
        onPressed: () {
          if (!isHomepage) {
            Navigator.of(context).pop(false);
          }
        },
      ),
      actions: [
        isHomepage
            ? IconButton(
                onPressed: () {
                  if (toggleSearch != null) {
                    toggleSearch!();
                  }
                },
                icon: Icon(Icons.search))
            : Container(),
        Stack(alignment: Alignment.center, children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_sharp),
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/cart') {
                Navigator.pushNamed(context, '/cart');
              }
            },
          ),
          Positioned(
            bottom: 8,
            right: 2,
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 17, 0),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: Text(
                  cartProvider.list.length.toString(),
                  style: TextStyle(fontSize: 12),
                ))),
          )
        ]),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
