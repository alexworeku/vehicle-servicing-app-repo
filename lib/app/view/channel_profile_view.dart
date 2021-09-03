import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/view/create_article_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_product_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_service_post_view.dart';
import 'package:vehicleservicingapp/app/view/create_channel_view.dart';
import 'package:vehicleservicingapp/app/view/map_view.dart';
import 'package:vehicleservicingapp/app/view/rating_view.dart';
import 'package:vehicleservicingapp/app/view/testimonial_view.dart';
import 'package:vehicleservicingapp/app/view/vehicles_view.dart';

import 'package:vehicleservicingapp/app/view/widgets/accessory_post_card_view.dart';

import 'package:vehicleservicingapp/app/view/widgets/article_post_card_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ChannelProfileView extends StatelessWidget {
  final Channel channel;
  final bool isAdmin;
  const ChannelProfileView({Key key, this.channel, this.isAdmin})
      : super(key: key);

  List<Widget> _getPosts() {
    return Get.find<ChannelController>().getPosts(channel.id).map((e) {
      if (channel.channelType == "Accessory") {
        return AccessoryPostCardView(
          accessoryPost: (e as AccessoryPost),
          isForAdmin: true,
        );
      } else if (channel.channelType == "Service") {
        return ServicePostCardWidget(
          servicePost: e as ServicePost,
          channel: channel,
          isForAdmin: true,
        );
      } else {
        return ArticlePostCardView(post: e as ArticlePost, isForAdmin: true);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                switch (channel.channelType) {
                  case "Accessory":
                    Get.to(() => CreateAccessoryPostView());
                    break;
                  case "Service":
                    Get.to(() => CreateServicePostView());

                    break;
                  case "Blog":
                    Get.to(() => CreateArticlePostView());
                    break;
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
                    Get.to(() => CreateChannelView(
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
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(channel.imageUrl),
                    radius: 50,
                  ),
                  Positioned(
                      top: 65,
                      left: 65,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_a_photo),
                      ))
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
                            Get.to(() => GiveTestimonialView());
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
                            color: channel.rating >= 3
                                ? Colors.orangeAccent
                                : Get.theme.iconTheme.color,
                          ),
                          onPressed: () {
                            Get.dialog(RatingView());
                          }),
                      Text(
                        channel.rating.toString(),
                        style: Get.theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                  channel.channelType == "Service" ||
                          channel.channelType == "Accessory"
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
                  channel.channelType == "Service"
                      ? Column(
                          children: [
                            IconButton(
                                icon: Icon(Icons.car_repair),
                                onPressed: () {
                                  Get.to(() => VehiclesView());
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
            Get.find<ChannelController>().getPostsCount(channel.id) != 0
                ? Column(
                    children: _getPosts(),
                  )
                : Text("No posts yet", style: Get.theme.textTheme.bodyText2),
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
            SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
