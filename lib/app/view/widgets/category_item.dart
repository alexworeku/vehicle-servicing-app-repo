import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  const CategoryItem({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Color.fromRGBO(245, 240, 245, 0.8),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 30,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 8),
      child: Text(
        categoryName,
        style: Get.theme.textTheme.bodyText1,
      ),
    );
  }
}
