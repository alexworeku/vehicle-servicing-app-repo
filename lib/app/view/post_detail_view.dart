import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/post.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:collection/collection.dart';

import 'channel_profile_view.dart';

class PostDetailView extends StatelessWidget {
  final Post post;
  final Channel channel;
  final bool isSavedArticlePost;

  const PostDetailView(
      {Key key, this.post, this.channel, this.isSavedArticlePost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(children: [
            CachedNetworkImage(
              imageUrl: post.imageUrl,
              placeholder: (ctx, imgProvider) =>
                  SpinKitCircle(color: Get.theme.primaryColor),
              errorWidget: (ctx, url, error) => Icon(Icons.error),
              imageBuilder: (ctx, imgProvider) {
                return Image(
                  width: Get.width,
                  height: Get.height * 0.43,
                  image: imgProvider,
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
                right: 15,
                top: 5,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 255, 255, 0.77),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                  ),
                ))
          ]),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSavedArticlePost
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            InkWell(
                                onTap: () {
                                  Get.to(() => ChannelProfileView(
                                        isAdmin: Get.find<UserController>()
                                                .getCurrentUserId() ==
                                            channel.userId,
                                        channel: channel,
                                      ));
                                },
                                child: channel.imageUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: channel.imageUrl,
                                        placeholder: (ctx, imgProvider) =>
                                            SpinKitCircle(
                                                color: Get.theme.primaryColor),
                                        errorWidget: (ctx, url, error) =>
                                            Icon(Icons.error),
                                        imageBuilder: (ctx, imgProvider) {
                                          return CircleAvatar(
                                              radius: 25,
                                              backgroundImage: imgProvider);
                                        },
                                      )
                                    : CircleAvatar(
                                        radius: 25,
                                        child: Icon(Icons.car_repair),
                                      )),
                            SizedBox(width: 4),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(channel.channelName,
                                      style: Get.theme.textTheme.subtitle1
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
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
                                      Text(channel.rating.average.toString(),
                                          style: Get.theme.textTheme.bodyText2)
                                    ],
                                  ),
                                ]),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: (post is ArticlePost)
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.thumb_up),
                                              onPressed: () {}),
                                          IconButton(
                                              icon: Icon(Icons.bookmark),
                                              onPressed: () {})
                                        ],
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.call),
                                        onPressed: () {}),
                              ),
                            )
                          ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          post is ServicePost
                              ? (post as ServicePost).serviceName
                              : (post is AccessoryPost
                                  ? (post as AccessoryPost).productName
                                  : (post as ArticlePost).title),
                          style: Get.theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                          post is ServicePost
                              ? "ETB: " + (post as ServicePost).price.toString()
                              : (post is AccessoryPost
                                  ? "ETB: " +
                                      (post as AccessoryPost).price.toString()
                                  : (post as ArticlePost).duration.toString() +
                                      "mins."),
                          style: Get.theme.textTheme.subtitle1)
                    ]),
                SizedBox(
                  height: 8,
                ),
                Text(
                  post is ServicePost
                      ? (post as ServicePost).serviceDescription
                      : (post is AccessoryPost
                          ? (post as AccessoryPost).productDescription
                          : (post as ArticlePost).content),
                  style: Get.theme.textTheme.bodyText2,
                ),
                SizedBox(height: 8),
                Text("Tags:", style: Get.theme.textTheme.subtitle1),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: post.tags
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Get.theme.accentIconTheme.color),
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  e.trim(),
                                  style: Get.theme.textTheme.caption,
                                ),
                              ),
                            )
                            .toList()))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
