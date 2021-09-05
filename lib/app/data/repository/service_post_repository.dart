import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iservice_repository.dart';

class ServicePostRepository implements IServiceRepository {
  @override
  Future<List<ServicePost>> getOwnedPosts(String type, String channelId) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Services")
        .where('ChannelId', isEqualTo: channelId)
        .get();
    var posts = <ServicePost>[];
    snapShot.docs.forEach((doc) {
      posts.add(ServicePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<List<ServicePost>> getPostsByType(String type) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Services")
        .where('ServiceType', isEqualTo: type)
        .get();
    var posts = <ServicePost>[];
    snapShot.docs.forEach((doc) {
      posts.add(ServicePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> add(ServicePost post) async {
    await FirebaseFirestore.instance.collection("Services").add(post.toMap());
  }

  @override
  Future<List<ServicePost>> getPostsByTag(String tag) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Services")
        .where('Tags', arrayContains: tag)
        .get();
    var posts = <ServicePost>[];
    snapShot.docs.forEach((doc) {
      posts.add(ServicePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> remove(String id) async {
    await FirebaseFirestore.instance.collection("Services").doc(id).delete();
  }
}
