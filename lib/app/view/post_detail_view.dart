import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/post.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:collection/collection.dart';

import 'channel_profile_view.dart';

class PostDetailView extends StatefulWidget {
  final Post post;
  final Channel channel;
  final bool isSavedArticlePost;

  const PostDetailView(
      {Key key, this.post, this.channel, this.isSavedArticlePost = false})
      : super(key: key);

  @override
  _PostDetailViewState createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(children: [
            CachedNetworkImage(
              imageUrl: widget.post.imageUrl,
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
                widget.isSavedArticlePost
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            InkWell(
                                onTap: () {
                                  Get.to(() => ChannelProfileView(
                                        isAdmin: Get.find<UserController>()
                                                .getCurrentUserId() ==
                                            widget.channel.userId,
                                        channel: widget.channel,
                                      ));
                                },
                                child: widget.channel.imageUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.channel.imageUrl,
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
                                  Text(widget.channel.channelName,
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
                                      Text(
                                          widget.channel.rating.isEmpty
                                              ? 0.0.toString()
                                              : widget.channel.rating.average
                                                  .toString(),
                                          style: Get.theme.textTheme.bodyText2)
                                    ],
                                  ),
                                ]),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: (widget.post is ArticlePost)
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text((widget.post as ArticlePost)
                                                  .likes
                                                  .toString()),
                                              IconButton(
                                                  icon: Icon(Icons.thumb_up),
                                                  onPressed: () {
                                                    Get.find<
                                                            ArticlePostController>()
                                                        .updateAccessoryPost(
                                                            widget.post.id,
                                                            "Likes",
                                                            (widget.post
                                                                        as ArticlePost)
                                                                    .likes +
                                                                1);
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.bookmark),
                                              onPressed: () async {
                                                var isSaved = await Get.find<
                                                        ArticlePostController>()
                                                    .savePostOffline(
                                                        widget.post);
                                                if (isSaved) {
                                                  Get.showSnackbar(GetBar(
                                                    title: "Offline save",
                                                    message: "Article saved",
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ));
                                                } else {
                                                  Get.showSnackbar(GetBar(
                                                    title: "Failed",
                                                    message: "Not saved",
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ));
                                                }
                                              })
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
                          widget.post is ServicePost
                              ? (widget.post as ServicePost).serviceName
                              : (widget.post is AccessoryPost
                                  ? (widget.post as AccessoryPost).productName
                                  : (widget.post as ArticlePost).title),
                          style: Get.theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                          widget.post is ServicePost
                              ? "ETB: " +
                                  (widget.post as ServicePost).price.toString()
                              : (widget.post is AccessoryPost
                                  ? "ETB: " +
                                      (widget.post as AccessoryPost)
                                          .price
                                          .toString()
                                  : (widget.post as ArticlePost)
                                          .duration
                                          .toString() +
                                      "mins."),
                          style: Get.theme.textTheme.subtitle1)
                    ]),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.post is ServicePost
                      ? (widget.post as ServicePost).serviceDescription
                      : (widget.post is AccessoryPost
                          ? (widget.post as AccessoryPost).productDescription
                          : (widget.post as ArticlePost).content),
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
                        children: widget.post.tags
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
