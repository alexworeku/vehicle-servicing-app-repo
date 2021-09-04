import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelCardWidget extends StatelessWidget {
  final String channelName, city;
  final double rating;
  final Image image;
  const ChannelCardWidget(
      {Key key, this.channelName, this.rating, this.image, this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image,
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(channelName, style: Get.theme.textTheme.subtitle1),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: Get.width * 0.6,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 17,
                        color: Color.fromRGBO(238, 205, 78, 1),
                      ),
                      Text(rating.toString(),
                          style: Get.theme.textTheme.bodyText2)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 17,
                      ),
                      Text(city, style: Get.theme.textTheme.bodyText2)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
