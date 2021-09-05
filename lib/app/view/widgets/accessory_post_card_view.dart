import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:collection/collection.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/view/widgets/channel_info_for_post_widget.dart';

class AccessoryPostCardView extends StatelessWidget {
  final AccessoryPost accessoryPost;
  final bool isForAdmin, isForChannelProfile;
  final Channel channel;
  const AccessoryPostCardView(
      {Key key,
      this.accessoryPost,
      this.isForAdmin = false,
      this.isForChannelProfile = false,
      this.channel})
      : super(key: key);
  Widget getPostForAdmin() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: accessoryPost.imageUrl,
            placeholder: (ctx, imgProvider) =>
                SpinKitCircle(color: Get.theme.primaryColor),
            errorWidget: (ctx, url, error) => Icon(Icons.error),
            imageBuilder: (ctx, imgProvider) {
              return Image(
                width: Get.width,
                height: Get.width * 0.45,
                image: imgProvider,
                fit: BoxFit.cover,
              );
            },
          ),
          isForChannelProfile
              ? Container()
              : ChannelInfoForPostWidget(channel: channel),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(accessoryPost.productName,
                      style: Get.theme.textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text("ETB " + accessoryPost.price.toString(),
                      style: Get.theme.textTheme.bodyText1)
                ]),
          ),
          SizedBox(
            height: 5,
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
                onPressed: () {
                  Get.showSnackbar(GetBar(
                      title: "Removing...",
                      message: "Please wait a moment",
                      icon: Icon(Icons.delete)));
                  FirebaseStorageProvider.removeImage(accessoryPost.imageUrl);
                  Get.find<AccessoryPostController>()
                      .removeAccessoryPost(accessoryPost.id);
                  Get.close(1);
                  Get.showSnackbar(
                    GetBar(
                      title: "Post Removed",
                      message: "Post Removed Successfully.",
                      icon: Icon(Icons.delete),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
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
                CachedNetworkImage(
                  imageUrl: accessoryPost.imageUrl,
                  placeholder: (ctx, imgProvider) =>
                      SpinKitCircle(color: Get.theme.primaryColor),
                  errorWidget: (ctx, url, error) => Icon(Icons.error),
                  imageBuilder: (ctx, imgProvider) {
                    return Image(
                      width: Get.width,
                      image: imgProvider,
                      fit: BoxFit.cover,
                    );
                  },
                ),
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
