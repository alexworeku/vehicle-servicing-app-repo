import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/ichannel_repository.dart';

class ChannelRepository implements IChannelRepository {
  @override
  Future<void> add(Channel channel) async {
    await FirebaseFirestore.instance
        .collection("Channels")
        .add(channel.toMap());
  }

  @override
  Future<List<Channel>> getAllByUserId(String userId) async {
    var docSnapshots = await FirebaseFirestore.instance
        .collection("Channels")
        .where("UserId", isEqualTo: userId)
        .get();
    List<Channel> channels = [];
    for (var doc in docSnapshots.docs) {
      channels.add(Channel.fromMap(doc.id, doc.data()));
    }
    return channels;
  }

  @override
  Future<List<Channel>> getNearBy(String type) {
    // TODO: implement getNearBy
    throw UnimplementedError();
  }

  @override
  Future<List<Channel>> getTopRated(String type, int limit) async {
    var docSnapshots = await FirebaseFirestore.instance
        .collection("Channels")
        .where("ChannelType", isEqualTo: type)
        .orderBy("Rating", descending: true)
        .limitToLast(limit)
        .get();
    List<Channel> channels = [];
    for (var doc in docSnapshots.docs) {
      channels.add(Channel.fromMap(doc.id, doc.data()));
    }
    return channels;
  }

  @override
  Future<void> update(String id, Channel channel) async {
    await FirebaseFirestore.instance.collection("Channels").doc(id).set(
        channel.toMap(),
        SetOptions(
          merge: true,
        ));
  }

  @override
  Future<void> addTestimonial(String channelId, String message) async {
    await FirebaseFirestore.instance
        .collection("Channels")
        .doc(channelId)
        .update({
      'Testimonials': FieldValue.arrayUnion([message])
    });
  }

  @override
  Future<void> remove(String channelId) async {
    await FirebaseFirestore.instance
        .collection("Channels")
        .doc(channelId)
        .delete();
  }

  @override
  Future<void> updateOnly(String id, String field, dynamic newValue) async {
    await FirebaseFirestore.instance
        .collection("Channels")
        .doc(id)
        .update({field: newValue});
  }

  @override
  Future<Channel> get(String id) async {
    var docSnapshot =
        await FirebaseFirestore.instance.collection("Channels").doc(id).get();
    return Channel.fromMap(docSnapshot.id, docSnapshot.data());
  }
}
