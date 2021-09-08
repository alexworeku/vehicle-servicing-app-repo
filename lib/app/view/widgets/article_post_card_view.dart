import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/channel_info_for_post_widget.dart';

class ArticlePostCardView extends StatefulWidget {
  final ArticlePost post;
  final bool isForAdmin;
  final Channel channel;
  final bool isForChannelProfile;
  const ArticlePostCardView(
      {Key key,
      @required this.post,
      this.isForAdmin = false,
      @required this.channel,
      this.isForChannelProfile = false})
      : super(key: key);

  @override
  _ArticlePostCardViewState createState() => _ArticlePostCardViewState();
}

class _ArticlePostCardViewState extends State<ArticlePostCardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        widget.isForChannelProfile
            ? Container()
            : ChannelInfoForPostWidget(channel: widget.channel),
        InkWell(
          onTap: () {
            Get.to(() => PostDetailView(
                  post: widget.post,
                  channel: widget.channel,
                ));
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 3),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.post.title,
                            style: Get.theme.textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(widget.post.duration.toString() + "mins.")
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: Get.height * 0.4,
                      width: Get.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.post.imageUrl,
                              placeholder: (ctx, imgProvider) =>
                                  SpinKitCircle(color: Get.theme.primaryColor),
                              errorWidget: (ctx, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (ctx, imgProvider) {
                                return Image(
                                  width: Get.width,
                                  height: Get.width * 0.45,
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.post.content,
                              style: Get.theme.textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: widget.isForAdmin
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.showSnackbar(GetBar(
                          title: "Removing...",
                          message: "Please wait a moment",
                          icon: Icon(Icons.delete)));
                      FirebaseStorageProvider.removeImage(widget.post.imageUrl);
                      Get.find<ArticlePostController>()
                          .removeArticlePost(widget.post.id);
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
                    icon: Icon(Icons.delete),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                            ),
                            onPressed: () {
                              Get.find<ArticlePostController>()
                                  .updateAccessoryPost(widget.post.id, "Likes",
                                      widget.post.likes + 1);
                              setState(() {});
                            }),
                        Text(
                          widget.post.likes.toString(),
                          style: Get.theme.textTheme.subtitle2,
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () async {
                          var isSaved = await Get.find<ArticlePostController>()
                              .savePostOffline(widget.post);
                          if (isSaved) {
                            Get.showSnackbar(GetBar(
                              title: "Offline save",
                              message: "Article saved",
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetBar(
                              title: "Failed",
                              message: "Not saved",
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }),
                  ],
                ),
        )
      ]),
    );
  }
}
