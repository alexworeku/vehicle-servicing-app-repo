import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';

class ServicePostCardWidget extends StatelessWidget {
  final ServicePost servicePost;
  final channelControlelr = Get.find<ChannelController>();

  ServicePostCardWidget({Key key, this.servicePost}) : super(key: key);

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
            Image(
              width: Get.width * 0.6,
              height: Get.width * 0.45,
              image: AssetImage(servicePost.imageUrl),
              fit: BoxFit.cover,
            ),
            FutureBuilder<Channel>(
                future: channelControlelr.getChannelById(servicePost.channelId),
                builder: (_, snapShot) {
                  if (snapShot.hasData) {
                    return Row(
                      //TODO:Change to network image
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child:
                                Image(image: AssetImage(servicePost.imageUrl))),
                        Text(snapShot.data.channelName)
                      ],
                    );
                  }
                  return SpinKitCircle();
                }),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(servicePost.serviceName,
                  style: Get.theme.textTheme.subtitle1),
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
                      Text(servicePost.price.toString(),
                          style: Get.theme.textTheme.bodyText2)
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.location_on,
                  //       size: 17,
                  //     ),
                  //     Text(city, style: Get.theme.textTheme.bodyText2)
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
