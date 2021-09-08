import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:collection/collection.dart';

class ChannelInfoForPostWidget extends StatelessWidget {
  final Channel channel;
  const ChannelInfoForPostWidget({Key key, @required this.channel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        channel.imageUrl != null
            ? CachedNetworkImage(
                imageUrl: channel.imageUrl,
                placeholder: (ctx, imgProvider) =>
                    SpinKitCircle(color: Get.theme.primaryColor),
                errorWidget: (ctx, url, error) => Icon(Icons.error),
                imageBuilder: (ctx, imgProvider) {
                  return CircleAvatar(radius: 20, backgroundImage: imgProvider);
                },
              )
            : CircleAvatar(
                radius: 20,
                child: Icon(Icons.car_repair),
              ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(channel.channelName, style: Get.theme.textTheme.subtitle1),
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
                Text(
                    channel.rating.isEmpty
                        ? 0.0.toString()
                        : channel.rating.average.toString(),
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
    );
  }
}
