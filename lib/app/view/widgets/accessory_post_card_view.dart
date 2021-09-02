import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

class AccessoryPostCardView extends StatelessWidget {
  final AccessoryPost accessoryPost;
  const AccessoryPostCardView({Key key, this.accessoryPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image(
                  image: AssetImage(accessoryPost.imageUrl),
                  fit: BoxFit.cover)),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              accessoryPost.productName,
              style: Get.theme.textTheme.subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text("ETB " + accessoryPost.price.toString()),
          ),
        ],
      ),
    );
  }
}
