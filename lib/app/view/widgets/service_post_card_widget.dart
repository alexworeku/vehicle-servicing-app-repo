import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';

import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/view/widgets/channel_info_for_post_widget.dart';

class ServicePostCardWidget extends StatelessWidget {
  final ServicePost servicePost;
  final Channel channel;
  final bool isForAdmin, isForChannelProfile;
  final channelControlelr = Get.find<ChannelController>();

  ServicePostCardWidget(
      {Key key,
      this.servicePost,
      this.channel,
      this.isForAdmin = false,
      this.isForChannelProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: servicePost.imageUrl,
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
              SizedBox(height: 5),
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
                      Text(servicePost.serviceName,
                          style: Get.theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text("ETB " + servicePost.price.toString(),
                          style: Get.theme.textTheme.bodyText1)
                    ]),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  servicePost.serviceDescription,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              isForAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Get.showSnackbar(GetBar(
                                  title: "Removing...",
                                  message: "Please wait a moment",
                                  icon: Icon(Icons.delete)));
                              FirebaseStorageProvider.removeImage(
                                  servicePost.imageUrl);
                              Get.find<ServicePostController>()
                                  .removeServicePost(servicePost.id);
                              Get.close(1);
                              Get.showSnackbar(
                                GetBar(
                                  title: "Post Removed",
                                  message: "Post Removed Successfully.",
                                  icon: Icon(Icons.delete),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            })
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
