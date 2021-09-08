import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/app_notification.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/inotification_repository.dart';

class NotificationController extends GetxController {
  INotificationRepository _notificationRepository;

  NotificationController(this._notificationRepository);
  void add(AppNotification notification) async {
    await _notificationRepository.add(notification);
  }

  void removeNotification(String id) async {
    await _notificationRepository.remove(id);
  }

  Future<List<AppNotification>> getAllNotification(String userId) async {
    return await _notificationRepository.getAll(userId);
  }
}
