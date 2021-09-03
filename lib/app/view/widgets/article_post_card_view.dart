import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';

class ArticlePostCardView extends StatelessWidget {
  final ArticlePost post;
  final bool isForAdmin;
  const ArticlePostCardView({Key key, this.post, this.isForAdmin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Channel>(
        future: Get.find<ChannelController>().getChannelById(post.channelId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: [
                InkWell(
                  onTap: () {
                    //TODO:Open Channel Profile
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(post.imageUrl),
                              )),
                        ),
                        SizedBox(width: 6),
                        Text(snapshot.data.channelName,
                            style: Get.theme.textTheme.subtitle1)
                      ]),
                ),
                InkWell(
                  onTap: () {
                    //TODO:OPen Post Detail
                    Get.to(() => PostDetailView(
                          post: post,
                          channel: snapshot.data,
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, top: 3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      post.title,
                                      style: Get.theme.textTheme.subtitle2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(post.duration.toString() + "mins.")
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      post.content,
                                      style: Get.theme.textTheme.bodyText2,
                                    ),
                                  ),
                                  Image(
                                      height: Get.width * 0.3,
                                      width: Get.width * 0.3,
                                      fit: BoxFit.cover,
                                      image: AssetImage(post.imageUrl))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child:  isForAdmin
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            )
                          :Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.thumb_up,
                                    ),
                                    onPressed: () {}),
                                Text(
                                  post.likes.toString(),
                                  style: Get.theme.textTheme.subtitle2,
                                )
                              ],
                            ),
                      IconButton(icon: Icon(Icons.bookmark), onPressed: () {}),
                    ],
                  ),
                )
              ]),
            );
          } else {
            return SpinKitCircle(color: Get.theme.primaryColor);
          }
        });
  }
}
