import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/view/notification_view.dart';
import 'package:vehicleservicingapp/app/view/owned_channels_view.dart';
import 'package:vehicleservicingapp/app/view/accessory_posts_view.dart';
import 'package:vehicleservicingapp/app/view/services_view.dart';
import 'package:vehicleservicingapp/app/view/settings_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/category_item.dart';
import 'package:vehicleservicingapp/app/view/widgets/channel_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavBarIndex = 0;

  var notificationController = Get.put(new NotificationController());
  var userController = Get.put(new UserController());
  var productController = Get.put(new AccessoryPostController());
  var channelController = Get.put(new ChannelController());
  var articleController = Get.put(new ArticlePostController());
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
                case 4:
                  Get.to(() => SettingsView());
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
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {},
                ),
              ),
            )
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
                            Get.to(
                                () => ServicesView(typeOfService: "Garages"));
                          },
                          child: CategoryItem(categoryName: "Garages")),
                      InkWell(
                          onTap: () {
                            Get.to(() => AccessoryPostsView());
                          },
                          child: CategoryItem(categoryName: "Accessories")),
                      CategoryItem(categoryName: "Tow-Trucks"),
                      CategoryItem(categoryName: "Bolo-Service"),
                      CategoryItem(categoryName: "Articles"),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: productController
                          .getAllPosts()
                          .map((p) => InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image(
                                            width: Get.width * 0.3,
                                            height: Get.width * 0.3,
                                            fit: BoxFit.cover,
                                            image: AssetImage(p.imageUrl)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        p.productName,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodyText1,
                                      ),
                                      Text(
                                        p.price.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodyText1
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                ),
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
                      children: channelController
                          .getGarageChannels()
                          .map(
                            (c) => InkWell(
                              child: ChannelCardWidget(
                                channelName: c.channelName,
                                city: c.city,
                                rating: c.rating,
                                image: Image(
                                  width: Get.width * 0.6,
                                  height: Get.width * 0.45,
                                  image: AssetImage(c.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList()),
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
                      children: channelController
                          .getTowtruckChannels()
                          .map((c) => InkWell(
                                child: ChannelCardWidget(
                                  channelName: c.channelName,
                                  city: c.city,
                                  rating: c.rating,
                                  image: Image(
                                    width: Get.width * 0.6,
                                    height: Get.width * 0.45,
                                    image: AssetImage(c.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList()),
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
                      children: channelController
                          .getBoloServiceProviderChannel()
                          .map((c) => InkWell(
                                child: ChannelCardWidget(
                                  channelName: c.channelName,
                                  city: c.city,
                                  rating: c.rating,
                                  image: Image(
                                    width: Get.width * 0.6,
                                    height: Get.width * 0.45,
                                    image: AssetImage(c.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList()),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: articleController
                          .getAllPosts()
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
                                          style: Get.theme.textTheme.subtitle1,
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: Get.width * 0.6,
                                        ),
                                        child: Text(
                                          a.content,
                                          style: Get.theme.textTheme.bodyText1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Image(
                                          width: Get.width * 0.6,
                                          height: Get.width * 0.45,
                                          image: AssetImage(a.imageUrl)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.thumb_up_alt_sharp),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  a.likes.toString(),
                                                  style: Get.theme.textTheme
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
                ),
              ),
            ]),
          ),
        ));
  }
}
