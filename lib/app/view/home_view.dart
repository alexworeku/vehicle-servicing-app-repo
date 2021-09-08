import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/repository/accessory_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/article_post_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/channel_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/notification_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/service_post_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/user_repository.dart';
import 'package:vehicleservicingapp/app/view/articles_view.dart';
import 'package:vehicleservicingapp/app/view/channel_profile_view.dart';
import 'package:vehicleservicingapp/app/view/notification_view.dart';
import 'package:vehicleservicingapp/app/view/owned_channels_view.dart';
import 'package:vehicleservicingapp/app/view/accessory_posts_view.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/saved_articles_view.dart';
import 'package:vehicleservicingapp/app/view/services_view.dart';
import 'package:vehicleservicingapp/app/view/settings_view.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/login_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/category_item.dart';
import 'package:vehicleservicingapp/app/view/widgets/channel_card_widget.dart';
import 'package:collection/collection.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavBarIndex = 0;

  var notificationController =
      Get.put(new NotificationController(new NotificationRepository()));
  var userController =
      Get.put(new UserController(userRepository: new UserRepository()));
  var accssoryController =
      Get.put(new AccessoryPostController(new AccessoryRepository()));
  var channelController =
      Get.put(new ChannelController(new ChannelRepository()));
  var articleController =
      Get.put(new ArticlePostController(new ArticlePostrepository()));
  var serviceController =
      Get.put(new ServicePostController(new ServicePostRepository()));
  var refreshController = RefreshController();
  Widget getServiceChannels(String title, String type) {
    return Container(
      width: Get.width,
      child: FutureBuilder<List<Channel>>(
          future: channelController.getTopRated(type, 10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: Get.theme.textTheme.headline6,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data
                            .map<Widget>((channel) => InkWell(
                                  onTap: () {
                                    Get.to(() => ChannelProfileView(
                                          isAdmin: userController
                                                  .getCurrentUserId() ==
                                              channel.userId,
                                          channel: channel,
                                        ));
                                  },
                                  child: ChannelCardWidget(
                                    channelName: channel.channelName,
                                    rating: channel.rating.isEmpty
                                        ? 0.0
                                        : channel.rating.average,
                                    city: channel.city,
                                    image: channel.imageUrl == null
                                        ? Center(child: Icon(Icons.car_repair))
                                        : CachedNetworkImage(
                                            imageUrl: channel.imageUrl,
                                            placeholder: (ctx, imgProvider) =>
                                                SpinKitCircle(
                                                    color:
                                                        Get.theme.primaryColor),
                                            errorWidget: (ctx, url, error) =>
                                                Icon(Icons.error),
                                            imageBuilder: (ctx, imgProvider) {
                                              return Image(
                                                width: Get.width,
                                                height: Get.width * 0.4,
                                                image: imgProvider,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }
            return Center(
              child: SpinKitCircle(
                size: 15,
                color: Get.theme.primaryColor,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: SettingsView()),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedNavBarIndex,
            onTap: (index) {
              if (index == 0) {
                return;
              }
              if (!userController.isLoggedIn.value) {
                Get.showSnackbar(GetBar(
                  title: "Login",
                  message: "You must login to access the requested features",
                  duration: Duration(seconds: 2),
                ));
                return;
              }

              switch (index) {
                case 1:
                  Get.to(() => OwnedChannelsView());
                  break;
                case 2:
                  Get.to(() => NotificationView());
                  break;
                case 3:
                  Get.to(() => SavedArticlesView());
                  break;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  backgroundColor: Get.theme.accentColor,
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Channel"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: "Notification"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: "Saved Articles"),
            ]),
        appBar: AppBar(
          title: Text(
            "Discover",
            style: Get.theme.textTheme.headline6,
          ),
          actions: [
            Obx(() => userController.isLoggedIn.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FutureBuilder<AppUser>(
                        future: userController.getCurrentUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint("Error:" + snapshot.error.toString());
                            return Text("Error");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return snapshot.data.profileImageUrl == null
                                ? CircleAvatar(
                                    radius: 20,
                                    child: Icon(Icons.person),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: snapshot.data.profileImageUrl,
                                    placeholder: (ctx, imgProvider) =>
                                        SpinKitCircle(
                                            color: Get.theme.primaryColor,
                                            size: 20),
                                    errorWidget: (ctx, url, error) =>
                                        Icon(Icons.error),
                                    imageBuilder: (ctx, imgProvider) {
                                      return CircleAvatar(
                                          radius: 20,
                                          backgroundImage: imgProvider);
                                    },
                                  );
                          }
                          return SpinKitCircle(
                            size: 20,
                            color: Get.theme.primaryColor,
                          );
                        }),
                  )
                : TextButton(
                    onPressed: () {
                      Get.to(() => LoginView());
                    },
                    child: Text("Login"))),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: SmartRefresher(
            controller: refreshController,
            header: WaterDropMaterialHeader(),
            enablePullDown: true,
            onRefresh: () {
              setState(() {});

              refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.to(() =>
                                      ServicesView(serviceType: "Garage"));
                                },
                                child: CategoryItem(categoryName: "Garages")),
                            InkWell(
                                onTap: () {
                                  Get.to(() => AccessoryPostsView());
                                },
                                child:
                                    CategoryItem(categoryName: "Accessories")),
                            InkWell(
                                onTap: () {
                                  Get.to(ServicesView(
                                    serviceType: "Tow-Truck",
                                  ));
                                },
                                child:
                                    CategoryItem(categoryName: "Tow-Trucks")),
                            InkWell(
                                onTap: () {
                                  Get.to(ServicesView(
                                    serviceType: "Bolo-Service",
                                  ));
                                },
                                child:
                                    CategoryItem(categoryName: "Bolo-Service")),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ArticlesView());
                                },
                                child: CategoryItem(categoryName: "Articles")),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Products list
                    Container(
                      width: Get.width,
                      child: FutureBuilder<List<AccessoryPost>>(
                          future: accssoryController.getAllPosts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data.isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "New products",
                                          style: Get.theme.textTheme.headline6,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                        ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: snapshot.data
                                              .map((p) =>
                                                  FutureBuilder<Channel>(
                                                      future: channelController
                                                          .getChannelById(
                                                              p.channelId),
                                                      builder: (ctx,
                                                          channelSnapShot) {
                                                        if (channelSnapShot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return InkWell(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  PostDetailView(
                                                                    post: p,
                                                                    channel:
                                                                        channelSnapShot
                                                                            .data,
                                                                  ));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          p.imageUrl,
                                                                      placeholder: (ctx,
                                                                              imgProvider) =>
                                                                          SpinKitCircle(
                                                                              color: Get.theme.primaryColor),
                                                                      errorWidget: (ctx,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                      imageBuilder:
                                                                          (ctx,
                                                                              imgProvider) {
                                                                        return Image(
                                                                          width:
                                                                              Get.width * 0.3,
                                                                          height:
                                                                              Get.width * 0.3,
                                                                          image:
                                                                              imgProvider,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    p.productName,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Get
                                                                        .theme
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                  Text(
                                                                    p.price
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Get
                                                                        .theme
                                                                        .textTheme
                                                                        .bodyText1
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return SpinKitCircle(
                                                            color: Get.theme
                                                                .primaryColor,
                                                          );
                                                        }
                                                      }))
                                              .toList()),
                                    )
                                  ],
                                );
                              } else {
                                return Center(child: Text("No posts yet"));
                              }
                            }
                            return Center(
                              child: SpinKitCircle(
                                size: 15,
                                color: Get.theme.primaryColor,
                              ),
                            );
                          }),
                    ),
                    Divider(
                      thickness: 0,
                    ),
                    getServiceChannels("Popular Garage", "Garage"),
                    getServiceChannels("Best Tow-Trucks", "Tow-Truck"),
                    getServiceChannels("Best Bolo-Service", "Bolo-Service"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top rated articles",
                          style: Get.theme.textTheme.headline6,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        )
                      ],
                    ),
                    Container(
                      width: Get.width,
                      child: FutureBuilder<List<ArticlePost>>(
                          future: articleController.getHighestRatedArticles(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data.isNotEmpty) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: snapshot.data
                                          .map((a) => FutureBuilder<Channel>(
                                              future: channelController
                                                  .getChannelById(a.channelId),
                                              builder: (ctx, asnapShot) {
                                                if (asnapShot.connectionState ==
                                                    ConnectionState.done) {
                                                  return InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            PostDetailView(
                                                              post: a,
                                                              channel: asnapShot
                                                                  .data,
                                                            ));
                                                      },
                                                      child: Card(
                                                        child: Container(
                                                          width:
                                                              Get.width * 0.8,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  maxWidth:
                                                                      Get.width *
                                                                          0.6,
                                                                ),
                                                                child: Text(
                                                                  a.title,
                                                                  style: Get
                                                                      .theme
                                                                      .textTheme
                                                                      .subtitle1,
                                                                ),
                                                              ),
                                                              ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  maxWidth:
                                                                      Get.width *
                                                                          0.6,
                                                                ),
                                                                child: Text(
                                                                  a.content,
                                                                  style: Get
                                                                      .theme
                                                                      .textTheme
                                                                      .bodyText1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      PostDetailView(
                                                                        post: a,
                                                                        channel:
                                                                            asnapShot.data,
                                                                      ));
                                                                },
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: a
                                                                      .imageUrl,
                                                                  placeholder: (ctx,
                                                                          imgProvider) =>
                                                                      SpinKitCircle(
                                                                          color: Get
                                                                              .theme
                                                                              .primaryColor),
                                                                  errorWidget: (ctx,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                  imageBuilder:
                                                                      (ctx,
                                                                          imgProvider) {
                                                                    return Image(
                                                                      width: Get
                                                                          .width,
                                                                      height: Get
                                                                              .width *
                                                                          0.45,
                                                                      image:
                                                                          imgProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      4.0,
                                                                  vertical: 7,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              articleController.updateAccessoryPost(a.id, "Likes", a.likes + 1);
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.thumb_up_alt_sharp)),
                                                                        SizedBox(
                                                                          width:
                                                                              4,
                                                                        ),
                                                                        Text(
                                                                          a.likes
                                                                              .toString(),
                                                                          style: Get
                                                                              .theme
                                                                              .textTheme
                                                                              .bodyText2,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(a.duration
                                                                            .toString() +
                                                                        " min read")
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                } else {
                                                  return SpinKitCircle(
                                                    color:
                                                        Get.theme.primaryColor,
                                                  );
                                                }
                                              }))
                                          .toList()),
                                );
                              } else {
                                return Center(child: Text("Not available yet"));
                              }
                            }
                            return Center(
                              child: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            );
                          }),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
