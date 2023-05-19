import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final int id;
  final bool isActive;
  final void Function(int id, String categoryName) handleActive;

  const CategoryItem(
      {Key? key,
      required this.categoryName,
      required this.id,
      required this.isActive,
      required this.handleActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
      onPressed: () {
        handleActive(id, categoryName);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive == true
                ? Color.fromARGB(255, 255, 81, 0)
                : const Color.fromARGB(40, 0, 0, 0)),
        child: Text(
          categoryName,
          style: TextStyle(
            color: isActive == true ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
