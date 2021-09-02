import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/notification.dart';

class NotificationController extends GetxController {
  var _notifications = <Notification>[
    new Notification(
        day: "2 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
    new Notification(
        day: "2 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
    new Notification(
        day: "2 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
    new Notification(
        day: "2 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
    new Notification(
        day: "2 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
    new Notification(
        day: "3 day ago",
        notificationMessage:
            "You have recieved a new service request.please call back to the user",
        userId: "alex"),
  ];

  NotificationController();
  List<Notification> get notifications => _notifications;
  int get notificationsCount => _notifications.length;
}
