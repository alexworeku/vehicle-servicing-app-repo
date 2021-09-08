import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_notification.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';

class AddNotificationView extends StatefulWidget {
  final Vehicle vehicle;
  final Channel channel;
  final bool isFromChannel;
  const AddNotificationView(
      {Key key, this.vehicle, this.channel, this.isFromChannel = false})
      : super(key: key);

  @override
  _AddNotificationViewState createState() => _AddNotificationViewState();
}

class _AddNotificationViewState extends State<AddNotificationView> {
  var messageController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Write something about the notification",
                  style: Get.theme.textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  maxLines: 4,
                  controller: messageController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the message that you want to send",
                      labelText: "Notification "),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (widget.isFromChannel) {
                            var userController = Get.find<UserController>();

                            if (await userController.userExistsByPhone(
                                widget.vehicle.ownerPhoneNumber)) {
                              var user =
                                  await userController.getUserByPhonenumber(
                                      widget.vehicle.ownerPhoneNumber);
                              Get.find<NotificationController>()
                                  .add(new AppNotification(
                                content: messageController.text,
                                senderType: "Channel",
                                sentDate: DateTime.now().toString(),
                                senderId: widget.channel.id,
                                recieverId: user.id,
                              ));
                              Get.showSnackbar(GetBar(
                                title: "Notification sent",
                                message:
                                    "Notification has been sent to the user",
                              ));
                            } else {
                              Get.showSnackbar(GetBar(
                                title: "User not found",
                                message:
                                    "User not found by the given phone number",
                              ));
                            }
                          } else {
                            Get.find<NotificationController>().add(
                                new AppNotification(
                                    content: messageController.text,
                                    senderId: Get.find<UserController>()
                                        .getCurrentUserId(),
                                    senderType: "User",
                                    recieverId: widget.channel.userId,
                                    sentDate: DateTime.now().toString()));
                            Get.showSnackbar(GetBar(
                              title: "Notification sent",
                              message: "Notification has been sent to the user",
                            ));
                          }
                        }
                      },
                      child: Text("Send")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
