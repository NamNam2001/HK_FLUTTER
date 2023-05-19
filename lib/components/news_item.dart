import 'package:demo1/model/NewsModel.dart';
import 'package:demo1/news_item_page.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  // NewsItem({Key? key}) : super(key: key);
  final NewsModel item;
  final defaultImage =
      'https://deconova.eu/wp-content/uploads/2016/02/default-placeholder.png';

  const NewsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsItemPage(item: item)));
      },
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              // Image radius
              child: Image.network(item.urlToImage ?? defaultImage,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            item.title ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            item.description ?? "",
            style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}
