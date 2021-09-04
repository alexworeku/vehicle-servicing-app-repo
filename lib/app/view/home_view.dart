import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/repository/accessory_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/article_post_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/channel_repository.dart';
import 'package:vehicleservicingapp/app/data/repository/user_repository.dart';
import 'package:vehicleservicingapp/app/view/articles_view.dart';
import 'package:vehicleservicingapp/app/view/notification_view.dart';
import 'package:vehicleservicingapp/app/view/owned_channels_view.dart';
import 'package:vehicleservicingapp/app/view/accessory_posts_view.dart';
import 'package:vehicleservicingapp/app/view/saved_articles_view.dart';
import 'package:vehicleservicingapp/app/view/services_view.dart';
import 'package:vehicleservicingapp/app/view/settings_view.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/login_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/category_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavBarIndex = 0;

  var notificationController = Get.put(new NotificationController());
  var userController =
      Get.put(new UserController(userRepository: new UserRepository()));
  var accssoryController =
      Get.put(new AccessoryPostController(new AccessoryRepository()));
  var channelController =
      Get.put(new ChannelController(new ChannelRepository()));
  var articleController =
      Get.put(new ArticlePostController(new ArticlePostrepository()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: SettingsView()),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedNavBarIndex,
            onTap: (index) {
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
                  backgroundColor: Get.theme.colorScheme.primary,
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
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
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
                            return CachedNetworkImage(
                              imageUrl: snapshot.data.profileImageUrl,
                              placeholder: (ctx, imgProvider) => SpinKitCircle(
                                  color: Get.theme.primaryColor, size: 12),
                              errorWidget: (ctx, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (ctx, imgProvider) {
                                return CircleAvatar(
                                    radius: 20, backgroundImage: imgProvider);
                              },
                            );
                          }
                          return SpinKitCircle(
                            size: 12,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            Get.to(() => ServicesView(serviceType: "Garage"));
                          },
                          child: CategoryItem(categoryName: "Garages")),
                      InkWell(
                          onTap: () {
                            Get.to(() => AccessoryPostsView());
                          },
                          child: CategoryItem(categoryName: "Accessories")),
                      InkWell(
                          onTap: () {
                            Get.to(ServicesView(
                              serviceType: "Tow-Truck",
                            ));
                          },
                          child: CategoryItem(categoryName: "Tow-Trucks")),
                      InkWell(
                          onTap: () {
                            Get.to(ServicesView(
                              serviceType: "Bolo-Service",
                            ));
                          },
                          child: CategoryItem(categoryName: "Bolo-Service")),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New products",
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
              Container(
                width: Get.width,
                child: FutureBuilder<List<AccessoryPost>>(
                    future: accssoryController.getAllPosts(),
                    builder: (context, snapshot) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: snapshot.data
                                .map((p) => InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // ClipRRect(
                                            //   borderRadius: BorderRadius.all(
                                            //       Radius.circular(10)),
                                            //   child: Image(
                                            //       width: Get.width * 0.3,
                                            //       height: Get.width * 0.3,
                                            //       fit: BoxFit.cover,
                                            //       image: AssetImage(p.imageUrl)),
                                            // ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              p.productName,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  Get.theme.textTheme.bodyText1,
                                            ),
                                            Text(
                                              p.price.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: Get
                                                  .theme.textTheme.bodyText1
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      );
                    }),
              ),
              Divider(
                thickness: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular garages",
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
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Tow-trucks",
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
              Container(
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
//load tow trucks
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best bolo-service providers",
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
              Container(
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      //load
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top rated articles",
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
              Container(
                width: Get.width,
                child: FutureBuilder<List<ArticlePost>>(
                    future: articleController.getHighestRatedArticles(),
                    builder: (context, snapshot) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: snapshot.data
                                .map((a) => InkWell(
                                        child: Card(
                                      child: Container(
                                        width: Get.width * 0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: Get.width * 0.6,
                                              ),
                                              child: Text(
                                                a.title,
                                                style: Get
                                                    .theme.textTheme.subtitle1,
                                              ),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: Get.width * 0.6,
                                              ),
                                              child: Text(
                                                a.content,
                                                style: Get
                                                    .theme.textTheme.bodyText1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Image(
                                            //     width: Get.width * 0.6,
                                            //     height: Get.width * 0.45,
                                            //     image: AssetImage(a.imageUrl)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .thumb_up_alt_sharp),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        a.likes.toString(),
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyText2,
                                                      )
                                                    ],
                                                  ),
                                                  Text(a.duration.toString() +
                                                      " min read")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )))
                                .toList()),
                      );
                    }),
              ),
            ]),
          ),
        ));
  }
}
