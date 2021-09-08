import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/provider/location_provider.dart';
import 'package:vehicleservicingapp/app/data/repository/add_notification_view.dart';
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

class ChannelProfileView extends StatefulWidget {
  final Channel channel;
  final bool isAdmin;
  const ChannelProfileView({Key key, this.channel, @required this.isAdmin})
      : super(key: key);

  @override
  _ChannelProfileViewState createState() => _ChannelProfileViewState();
}

class _ChannelProfileViewState extends State<ChannelProfileView> {
  var refreshController = new RefreshController();
  var currentChannel;
  Future<List<Widget>> _getPosts(Channel ch) async {
    if (["Garage", "Tow-Truck", "Bolo-Service"].contains(ch.channelType)) {
      var posts = await Get.find<ServicePostController>()
          .getOwnedPosts(ch.id, ch.channelType);
      var postwidgets = posts
          .map((p) => ServicePostCardWidget(
                servicePost: p,
                channel: ch,
                isForChannelProfile: true,
                isForAdmin: widget.isAdmin,
              ))
          .toList();
      return postwidgets;
    } else if (ch.channelType == "Accessory") {
      return (await Get.find<AccessoryPostController>().getOwnedPosts(ch.id))
          .map((p) => AccessoryPostCardView(
                accessoryPost: p,
                channel: ch,
                isForChannelProfile: true,
                isForAdmin: true,
              ))
          .toList();
    } else {
      return (await Get.find<ArticlePostController>().getOwnedArticles(ch.id))
          .map((p) => ArticlePostCardView(
              channel: ch,
              post: p,
              isForChannelProfile: true,
              isForAdmin: true))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    currentChannel = widget.channel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                if (["Garage", "Tow-Truck", "Bolo-Service"]
                    .contains(currentChannel.channelType)) {
                  Get.to(() => CreateServicePostView(
                        channel: currentChannel,
                      ));
                } else if (currentChannel.channelType == "Accessory") {
                  Get.to(() => CreateAccessoryPostView(
                        channel: currentChannel,
                      ));
                } else {
                  Get.to(() => CreateArticlePostView(
                        channelId: currentChannel.id,
                      ));
                }
              },
            )
          : Container(),
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          widget.isAdmin
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(() => CreateOrUpdateChannelView(
                          channel: currentChannel,
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
        child: FutureBuilder<Channel>(
            future:
                Get.find<ChannelController>().getChannelById(currentChannel.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                currentChannel = snapshot.data;
                if (snapshot.data != null) {
                  return SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    header: WaterDropMaterialHeader(),
                    onRefresh: () {
                      setState(() {});

                      refreshController.refreshCompleted();
                    },
                    child: ListView(
                      children: [
                        Column(children: [
                          Stack(
                            children: [
                              ProfileImageWidget(
                                  profileUrl: snapshot.data.imageUrl,
                                  isChannelProfile: true,
                                  isForAdmin: widget.isAdmin,
                                  channelId: snapshot.data.id),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(snapshot.data.channelName,
                              style: Get.theme.textTheme.headline6),
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
                              Text(snapshot.data.city,
                                  style: Get.theme.textTheme.subtitle1),
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
                              Text(snapshot.data.phoneNum.toString(),
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
                                        if (!widget.isAdmin &&
                                            Get.find<UserController>()
                                                .isLoggedIn
                                                .value) {
                                          Get.bottomSheet(
                                            GiveTestimonialView(
                                              channelId: snapshot.data.id,
                                            ),
                                          );
                                        } else {
                                          Get.showSnackbar(GetBar(
                                            title: "Login",
                                            message:
                                                "You must login to access the requested features",
                                            duration: Duration(seconds: 2),
                                          ));
                                        }
                                      }),
                                  Text(
                                    snapshot.data.testimonials.length
                                        .toString(),
                                    style: Get.theme.textTheme.subtitle2,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        // color: snapshot.data.rating.average >= 3
                                        //     ? Colors.orangeAccent
                                        //     : Get.theme.iconTheme.color,
                                      ),
                                      onPressed: () {
                                        if (!widget.isAdmin &&
                                            Get.find<UserController>()
                                                .isLoggedIn
                                                .value) {
                                          Get.dialog(RatingView(
                                            onRated: (int newRating) =>
                                                Get.find<ChannelController>()
                                                    .addRating(snapshot.data.id,
                                                        newRating),
                                          ));
                                        } else {
                                          Get.showSnackbar(GetBar(
                                            title: "Login",
                                            message:
                                                "You must login to access the requested features",
                                            duration: Duration(seconds: 2),
                                          ));
                                        }
                                      }),
                                  Text(
                                    snapshot.data.rating.isEmpty
                                        ? 0.toString()
                                        : snapshot.data.rating.average
                                            .toString(),
                                    style: Get.theme.textTheme.subtitle2,
                                  )
                                ],
                              ),
                              !["Blog", "Tow-Truck", "Accessories"]
                                      .contains(snapshot.data.channelType)
                                  ? Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.add_location),
                                            onPressed: () async {
                                              if (widget.isAdmin) {
                                                Get.showSnackbar(GetBar(
                                                  icon: SpinKitCircle(
                                                      color: Get
                                                          .theme.primaryColor),
                                                  title: "Loading...",
                                                  message:
                                                      "Loading your current location",
                                                ));
                                                var currentLocation =
                                                    await LocationProvider
                                                        .getCurrentLocation();

                                                Get.find<ChannelController>()
                                                    .updateChannelProfile(
                                                        snapshot.data.id,
                                                        "Location",
                                                        GeoPoint(
                                                            currentLocation
                                                                .latitude,
                                                            currentLocation
                                                                .longitude));
                                                Get.close(1);
                                                Get.showSnackbar(GetBar(
                                                  title: "Saved...",
                                                  duration:
                                                      Duration(seconds: 3),
                                                  message:
                                                      "Your current location is saved as a location for your business",
                                                ));
                                              } else {
                                                if (snapshot.data.location !=
                                                    null) {
                                                  var geoPoint = snapshot
                                                      .data.location
                                                      .split(',');
                                                  await MapsLauncher
                                                      .launchCoordinates(
                                                    double.parse(geoPoint[0]),
                                                    double.parse(geoPoint[1]),
                                                  );
                                                } else {
                                                  Get.showSnackbar(GetBar(
                                                    title: "Location",
                                                    duration:
                                                        Duration(seconds: 3),
                                                    message:
                                                        "Location not available",
                                                  ));
                                                }
                                              }
                                            }),
                                        Text(
                                          widget.isAdmin
                                              ? "Set location"
                                              : "View on map",
                                          style: Get.theme.textTheme.subtitle2,
                                        )
                                      ],
                                    )
                                  : Container(),
                              ![
                                        "Blog",
                                        "Tow-Truck",
                                        "Accessory"
                                      ].contains(snapshot.data.channelType) &&
                                      widget.isAdmin
                                  ? Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.car_repair),
                                            onPressed: () {
                                              Get.to(() => VehiclesView(
                                                    channel: snapshot.data,
                                                  ));
                                            }),
                                        Text(
                                          "Vehicles",
                                          style: Get.theme.textTheme.subtitle2,
                                        )
                                      ],
                                    )
                                  : Container(),
                              !widget.isAdmin &&
                                      ["Tow-Truck", "Accessory", "Garage"]
                                          .contains(snapshot.data.channelType)
                                  ? Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () {
                                              if (!widget.isAdmin &&
                                                  Get.find<UserController>()
                                                      .isLoggedIn
                                                      .value) {
                                                Get.bottomSheet(
                                                    AddNotificationView(
                                                  channel: widget.channel,
                                                ));
                                              } else {
                                                Get.showSnackbar(GetBar(
                                                  title: "Login",
                                                  message:
                                                      "You must login to access the requested features",
                                                  duration:
                                                      Duration(seconds: 2),
                                                ));
                                              }
                                            }),
                                        Text(
                                          "Request",
                                          style: Get.theme.textTheme.subtitle2,
                                        )
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            snapshot.data.description,
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
                          future: _getPosts(snapshot.data),
                          builder: (ctx, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.done) {
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
                        snapshot.data.testimonials.isNotEmpty
                            ? SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: snapshot.data.testimonials
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
                  );
                } else {
                  return Center(
                    child: Text("No Data Yet"),
                  );
                }
              }
              return Center(
                child: SpinKitCircle(
                  color: Get.theme.primaryColor,
                ),
              );
            }),
      ),
    );
  }
}
