import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_notification.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/channel_profile_view.dart';
import 'package:vehicleservicingapp/app/view/user_profile_view.dart';

class NotificationView extends StatefulWidget {
  NotificationView({Key key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final notificationController = Get.find<NotificationController>();

  final refreshController = RefreshController();
  String getDateDifference(String sentDate) {
    return DateTime.now()
        .difference(DateTime.parse(sentDate))
        .inDays
        .toString();
  }

  Widget getChannelNotification(AppNotification notification) {
    return FutureBuilder<Channel>(
        future:
            Get.find<ChannelController>().getChannelById(notification.senderId),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return ListTile(
              leading: snapShot.data != null
                  ? CachedNetworkImage(
                      imageUrl: snapShot.data.imageUrl,
                      placeholder: (ctx, imgProvider) =>
                          SpinKitCircle(color: Get.theme.primaryColor),
                      errorWidget: (ctx, url, error) => Icon(Icons.error),
                      imageBuilder: (ctx, imgProvider) {
                        return CircleAvatar(
                            radius: 50, backgroundImage: imgProvider);
                      },
                    )
                  : CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person),
                    ),
              title: Text(snapShot.data.channelName),
              subtitle: Text(notification.content),
              trailing: IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  //TODO: Open Default phone pp
                },
              ),
            );
          }
          return SpinKitCircle(
            color: Get.theme.primaryColor,
          );
        });
  }

  Widget getUserNotification(AppNotification notification) {
    return FutureBuilder<AppUser>(
        future: Get.find<UserController>().getUserById(notification.senderId),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return ListTile(
              leading: snapShot.data.profileImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: snapShot.data.profileImageUrl,
                      placeholder: (ctx, imgProvider) =>
                          SpinKitCircle(color: Get.theme.primaryColor),
                      errorWidget: (ctx, url, error) => Icon(Icons.error),
                      imageBuilder: (ctx, imgProvider) {
                        return CircleAvatar(
                            radius: 30, backgroundImage: imgProvider);
                      },
                    )
                  : CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
              title: Text(snapShot.data.fullName),
              subtitle: Text(notification.content),
              trailing: IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  //TODO: Open Default phone pp
                },
              ),
            );
          }
          return SpinKitCircle(
            color: Get.theme.primaryColor,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8),
        width: Get.width,
        height: Get.height,
        child: FutureBuilder<List<AppNotification>>(
            future: notificationController.getAllNotification(
                Get.find<UserController>().getCurrentUserId()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isNotEmpty) {
                  return SmartRefresher(
                    controller: refreshController,
                    header: WaterDropMaterialHeader(),
                    enablePullDown: true,
                    onRefresh: () {
                      setState(() {});

                      refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              snapshot.data[index].senderType == "Channel"
                                  ? getChannelNotification(snapshot.data[index])
                                  : getUserNotification(snapshot.data[index]),
                              Divider(
                                thickness: 0,
                              )
                            ],
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Text("No notifications yet"),
                  );
                }
              }
              return Center(
                  child: SpinKitCircle(color: Get.theme.primaryColor));
            }),
      ),
    );
  }
}
