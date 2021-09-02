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
    var accessoriesRef = await FirebaseFirestore.instance
        .collection("Accessories")
        .withConverter<AccessoryPost>(
            fromFirestore: (snapShot, _) =>
                AccessoryPost.fromMap(snapShot.id, snapShot.data()),
            toFirestore: (post, _) => post.toMap())
        .get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((element) {
      posts.add(element.data());
    });
    return posts;
  }

  @override
  Future<List<AccessoryPost>> getAccessoryPostsByTag(String tag) async {
    var accessoriesRef = await FirebaseFirestore.instance
        .collection("Accessories")
        .withConverter<AccessoryPost>(
            fromFirestore: (snapShot, _) =>
                AccessoryPost.fromMap(snapShot.id, snapShot.data()),
            toFirestore: (post, _) => post.toMap())
        .where('Tag', arrayContains: tag)
        .get();
    List<AccessoryPost> posts = [];
    accessoriesRef.docs.forEach((element) {
      posts.add(element.data());
    });
    return posts;
  }

  @override
  Future<void> remove(String id) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Accessories");
    return collectionRef.doc(id).delete();
  }
}
