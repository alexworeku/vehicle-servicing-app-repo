import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularGarageCard extends StatelessWidget {
  final double distance;
  final String title, description;
  final Widget image;
  const PopularGarageCard(
      {Key key, this.image, this.title, this.distance, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image,
            SizedBox(
              width: 7,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      title,
                      style: Get.theme.textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      distance.toString() + " m",
                      style: Get.theme.textTheme.caption,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      description,
                      style: Get.theme.textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextButton(onPressed: () {}, child: Text("More"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
