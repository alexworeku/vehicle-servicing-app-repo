import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'interfaces/iaccessory_repository.dart';

class AccessoryRepository implements IAccessoryRepository {
  @override
  Future<void> add(AccessoryPost post) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Accessories");
    var docRef = await collectionRef.add(post.toMap());
    return docRef.id != null;
  }

  @override
  Future<List<AccessoryPost>> getAll() async {
    var accessoriesRef =
        await FirebaseFirestore.instance.collection("Accessories").get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((doc) {
      posts.add(AccessoryPost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<List<AccessoryPost>> getAllByTag(String tag) async {
    var accessoriesRef = await FirebaseFirestore.instance
        .collection("Accessories")
        .where('Tags', arrayContains: tag)
        .get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((doc) {
      posts.add(AccessoryPost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> remove(String id) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Accessories");
    return collectionRef.doc(id).delete();
  }

  @override
  Future<List<AccessoryPost>> getOwnedPosts(String channelId) async {
    var accessoriesRef = await FirebaseFirestore.instance
        .collection("Accessories")
        .where('ChannelId', isEqualTo: channelId)
        .get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((doc) {
      posts.add(AccessoryPost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<List<AccessoryPost>> getTop(int limit) async {
    var accessoriesRef = await FirebaseFirestore.instance
        .collection("Accessories")
        .orderBy("RegisteredDate", descending: true)
        .limit(limit)
        .get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((doc) {
      posts.add(AccessoryPost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }
}
