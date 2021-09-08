import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/app_notification.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/inotification_repository.dart';

class NotificationRepository implements INotificationRepository {
  @override
  Future<void> add(AppNotification notification) async {
    await FirebaseFirestore.instance
        .collection("Notifications")
        .add(notification.toMap());
  }

  @override
  Future<List<AppNotification>> getAll(String recieverId) async {
    var result = await FirebaseFirestore.instance
        .collection("Notifications")
        .where("Reciever", isEqualTo: recieverId)
        .get();
    List<AppNotification> posts = [];
    result.docs.forEach((doc) {
      posts.add(AppNotification.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> remove(String id) async {
    await FirebaseFirestore.instance
        .collection('Notifications')
        .doc(id)
        .delete();
  }
}
