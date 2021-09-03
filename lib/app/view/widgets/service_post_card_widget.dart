import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';

class ServicePostCardWidget extends StatelessWidget {
  final ServicePost servicePost;
  final Channel channel;
  final bool isForAdmin;
  final channelControlelr = Get.find<ChannelController>();

  ServicePostCardWidget(
      {Key key, this.servicePost, this.channel, this.isForAdmin = false})
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
              Image(
                width: Get.width,
                height: Get.width * 0.45,
                image: AssetImage(servicePost.imageUrl),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5),
              isForAdmin
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(mainAxisSize: MainAxisSize.max,
                          //TODO:Change to network image
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(servicePost.imageUrl),
                                  )),
                            ),
                            SizedBox(width: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(channel.channelName,
                                    style: Get.theme.textTheme.subtitle1),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color.fromRGBO(238, 205, 78, 1),
                                    ),
                                    Text(channel.rating.toString(),
                                        style: Get.theme.textTheme.bodyText2)
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on, size: 14),
                                    SizedBox(width: 3),
                                    Text(channel.city)
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(icon: Icon(Icons.delete), onPressed: () {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
