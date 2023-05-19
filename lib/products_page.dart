import 'package:demo1/components/app_bar.dart';
import 'package:demo1/components/category_item.dart';
import 'package:demo1/components/product_item.dart';
import 'package:demo1/provider/Category.dart';
import 'package:demo1/provider/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int activeCategoryItemId = 0;
  String activeCategory = "";
  String searchValue = "";
  bool productGridViewType = false;
  String activeFilter = "A-Z";
  bool showSearchField = false;

  List<String> filterList = ["A-Z", "Z-A", "Giá thấp", "Giá cao"];

  Timer? _debounce;

  void toggleSearch() {
    setState(() {
      showSearchField = !showSearchField;
    });
  }

  void getList() {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.getList(activeCategory, searchValue, activeFilter);
  }

  void changeCategory(int id, String categoryName) {
    setState(() {
      activeCategoryItemId = id;
      activeCategory = categoryName == "Tất cả" ? "" : categoryName;
    });
    getList();
  }

  void search(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchValue = value;
      });
      getList();
    });
  }

  void changeFilter(value) {
    setState(() {
      activeFilter = value;
      getList();
    });
  }

  @override
  void initState() {
    super.initState();
    var categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    getList();
    categoryProvider.getList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isHomepage: true,
        toggleSearch: toggleSearch,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                height: showSearchField ? 50 : 0,
                child: showSearchField
                    ? TextField(
                        decoration: InputDecoration(
                          label: const Text("Tìm kiếm sản phẩm"),
                          hintText: "Tìm kiếm sản phẩm",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          search(value);
                        },
                      )
                    : Container(),
              ),
            ),
            // showSearchField
            //     ? TextField(
            //         decoration: InputDecoration(
            //           label: const Text("Tìm kiếm sản phẩm"),
            //           hintText: "Tìm kiếm sản phẩm",
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           prefixIcon: const Icon(Icons.search),
            //         ),
            //         onChanged: (value) {
            //           search(value);
            //         },
            //       )
            //     : Container(),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryItem(
                      categoryName: "Tất cả",
                      id: 0,
                      isActive: 0 == activeCategoryItemId,
                      handleActive: changeCategory),
                  ...categoryProvider.list.asMap().entries.map((entry) {
                    int idx = entry.key + 1;
                    var e = entry.value;
                    return CategoryItem(
                        categoryName: e,
                        id: idx,
                        isActive: idx == activeCategoryItemId,
                        handleActive: changeCategory);
                  }).toList()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sản phẩm mới nhất",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: activeFilter,
                        icon: const Icon(Icons.filter_alt_outlined),
                        items: filterList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          changeFilter(value);
                        }),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            productGridViewType = true;
                          });
                        },
                        icon: const Icon(Icons.grid_view_sharp)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            productGridViewType = false;
                          });
                        },
                        icon: const Icon(Icons.list_alt_sharp))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
                child: productProvider.list.isNotEmpty
                    ? productGridViewType
                        ? GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            children: productProvider.list.map((e) {
                              return ProductItem(
                                item: e,
                                gridView: productGridViewType,
                              );
                            }).toList(),
                          )
                        : ListView(
                            children: productProvider.list.map((e) {
                              return ProductItem(
                                item: e,
                                gridView: productGridViewType,
                              );
                            }).toList(),
                          )
                    : buildEmpty())
          ],
        ),
      ),
    );
  }

  buildEmpty() {
    return const Center(
        child: Text(
      "Không có sản phẩm cần tìm",
      style: TextStyle(fontSize: 24),
    ));
  }
}
