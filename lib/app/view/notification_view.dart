import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/view/user_profile_view.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key key}) : super(key: key);
  final notificationController = Get.find<NotificationController>();
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
        child: ListView.builder(
            itemCount: notificationController.notificationsCount,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text("Alex"),
                    leading: IconButton(
                      onPressed: () {
                        Get.to(() => UserProfileView(
                              user: Get.find<UserController>().getUserWith(
                                  notificationController
                                      .notifications[index].userId),
                            ));
                      },
                      icon: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {
                        //TODO:Open default phone app
                      },
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notificationController
                            .notifications[index].notificationMessage),
                        SizedBox(
                          height: 3,
                        ),
                        Text(notificationController.notifications[index].day),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0,
                  )
                ],
              );
            }),
      ),
    );
  }
}
