import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final double width, height;
  final Color background;
  final bool isProductCard;
  const CustomCard(
      {Key key,
      this.title,
      this.subtitle,
      this.child,
      this.width,
      this.height,
      this.background,
      this.isProductCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          child: Card(
            color: background,
            child: child,
          ),
        ),
        // Text(
        //   title,
        //   style: Get.theme.textTheme.subtitle2,
        // ),
        isProductCard
            ? Text(
                subtitle,
                style: Get.theme.textTheme.caption,
              )
            : Container()
      ],
    );
  }
}
