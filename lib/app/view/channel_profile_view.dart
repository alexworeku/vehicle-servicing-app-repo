import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/create_article_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_accessory_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_service_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_or_update_channel_view.dart';
import 'package:vehicleservicingapp/app/view/map_view.dart';
import 'package:vehicleservicingapp/app/view/rating_view.dart';
import 'package:vehicleservicingapp/app/view/testimonial_view.dart';
import 'package:vehicleservicingapp/app/view/vehicles_view.dart';
import 'package:collection/collection.dart';
import 'package:vehicleservicingapp/app/view/widgets/accessory_post_card_view.dart';

import 'package:vehicleservicingapp/app/view/widgets/article_post_card_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/profile_image_widget.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ChannelProfileView extends StatelessWidget {
  final Channel channel;
  final bool isAdmin;
  const ChannelProfileView({Key key, this.channel, @required this.isAdmin})
      : super(key: key);

  Future<List<Widget>> _getPosts() async {
    if (["Garage", "Tow-Truck", "Bolo-Service"].contains(channel.channelType)) {
      var posts = await Get.find<ServicePostController>()
          .getOwnedPosts(channel.id, channel.channelType);
      var postwidgets = posts
          .map((p) => ServicePostCardWidget(
                servicePost: p,
                channel: channel,
                isForChannelProfile: true,
                isForAdmin: isAdmin,
              ))
          .toList();
      return postwidgets;
    } else if (channel.channelType == "Accessory") {
      return (await Get.find<AccessoryPostController>()
              .getOwnedPosts(channel.id))
          .map((p) => AccessoryPostCardView(
                accessoryPost: p,
                channel: channel,
                isForChannelProfile: true,
                isForAdmin: true,
              ))
          .toList();
    } else {
      return (await Get.find<ArticlePostController>().getHighestRatedArticles())
          .map((p) => ArticlePostCardView(
              channel: channel,
              post: p,
              isForChannelProfile: true,
              isForAdmin: true))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                if (["Garage", "Tow-Truck", "Bolo-Service"]
                    .contains(channel.channelType)) {
                  Get.to(() => CreateServicePostView(
                        channel: channel,
                      ));
                } else if (channel.channelType == "Accessory") {
                  Get.to(() => CreateAccessoryPostView(
                        channel: channel,
                      ));
                } else {
                  Get.to(() => CreateArticlePostView(
                        channelId: channel.id,
                      ));
                }
              },
            )
          : Container(),
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          isAdmin
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(() => CreateOrUpdateChannelView(
                          channel: channel,
                          showEditForm: true,
                        ));
                  })
              : IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    //TODO:Open default phone app
                  })
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 13, right: 13, top: 10),
        width: Get.width,
        child: ListView(
          children: [
            Column(children: [
              Stack(
                children: [
                  ProfileImageWidget(
                      profileUrl: channel.imageUrl,
                      isChannelProfile: true,
                      isForAdmin: isAdmin,
                      channelId: channel.id),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(channel.channelName, style: Get.theme.textTheme.headline6),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(channel.city, style: Get.theme.textTheme.subtitle1),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(channel.phoneNum.toString(),
                      style: Get.theme.textTheme.bodyText2),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.comment,
                          ),
                          onPressed: () {
                            if (!isAdmin) {
                              Get.bottomSheet(
                                GiveTestimonialView(
                                  channelId: channel.id,
                                ),
                              );
                            }
                          }),
                      Text(
                        channel.testimonials.length.toString(),
                        style: Get.theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.star,
                            color: channel.rating.average >= 3
                                ? Colors.orangeAccent
                                : Get.theme.iconTheme.color,
                          ),
                          onPressed: () {
                            if (isAdmin) {
                              Get.dialog(RatingView(
                                onRated: (int newRating) =>
                                    Get.find<ChannelController>()
                                        .addRating(channel.id, newRating),
                              ));
                            }
                          }),
                      Text(
                        channel.rating.average.toString(),
                        style: Get.theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                  !["Blog", "Tow-Truck", "Accessories"]
                          .contains(channel.channelType)
                      ? Column(
                          children: [
                            IconButton(
                                icon: Icon(Icons.add_location),
                                onPressed: () {
                                  Get.to(() => MapView());
                                }),
                            Text(
                              isAdmin ? "Set location" : "View on map",
                              style: Get.theme.textTheme.subtitle2,
                            )
                          ],
                        )
                      : Container(),
                  !["Blog", "Tow-Truck", "Accessory"]
                              .contains(channel.channelType) &&
                          isAdmin
                      ? Column(
                          children: [
                            IconButton(
                                icon: Icon(Icons.car_repair),
                                onPressed: () {
                                  Get.to(() => VehiclesView(
                                        channelId: channel.id,
                                      ));
                                }),
                            Text(
                              "Vehicles",
                              style: Get.theme.textTheme.subtitle2,
                            )
                          ],
                        )
                      : Container()
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                channel.description,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Posts",
                  style: Get.theme.textTheme.headline6,
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<Widget>>(
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  if (snapShot.data.isNotEmpty) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: snapShot.data,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No posts yet"),
                    );
                  }
                }
                return Center(
                    child: SpinKitCircle(
                  color: Get.theme.primaryColor,
                  size: 40,
                ));
              },
              future: _getPosts(),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Testimonials",
                style: Get.theme.textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            channel.testimonials.isNotEmpty
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: channel.testimonials
                          .map((e) => Card(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(12),
                                  width: Get.width,
                                  height: Get.height * 0.2,
                                  child: Text(e),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Center(child: Text("No testimonials given"))
          ],
        ),
      ),
    );
  }
}
