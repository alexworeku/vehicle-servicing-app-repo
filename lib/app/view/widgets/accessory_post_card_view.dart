import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

class AccessoryPostCardView extends StatelessWidget {
  final AccessoryPost accessoryPost;
  final bool isForAdmin;
  const AccessoryPostCardView(
      {Key key, this.accessoryPost, this.isForAdmin = false})
      : super(key: key);
  Widget getPostForAdmin() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            width: Get.width,
            height: Get.width * 0.45,
            image: AssetImage(accessoryPost.imageUrl),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  accessoryPost.productName + ", " + accessoryPost.brand,
                  style: Get.theme.textTheme.subtitle1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  accessoryPost.price.toString(),
                  style: Get.theme.textTheme.subtitle2,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(accessoryPost.productDescription,
                style: Get.theme.textTheme.bodyText1),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isForAdmin
        ? getPostForAdmin()
        : Container(
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
