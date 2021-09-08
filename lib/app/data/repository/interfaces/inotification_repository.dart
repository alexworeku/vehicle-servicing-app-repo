import 'package:vehicleservicingapp/app/data/model/app_notification.dart';

abstract class INotificationRepository {
  Future<void> add(AppNotification notification);
  Future<List<AppNotification>> getAll(String userId);
  Future<void> remove(String notification);
}
