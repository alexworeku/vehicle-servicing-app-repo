import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {
  static Future<String> uploadImage(File image) async {
    String imageTitle =
        Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch.toString();
    var ref = FirebaseStorage.instance.ref().child(imageTitle);
    await ref.putFile(image);

    return ref.getDownloadURL();
  }

  static Future<String> uploadAndReplaceImage(
      File image, String previousImageUrl) async {
    String imageTitle =
        Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch.toString();
    var ref = FirebaseStorage.instance.ref();
    var previousFileName = previousImageUrl.substring(
        previousImageUrl.lastIndexOf("/") + 1, previousImageUrl.indexOf("?"));
    await ref.child(previousFileName).delete();
    await ref.child(imageTitle).putFile(image);

    return ref.child(imageTitle).getDownloadURL();
  }

  static void removeImage(String imageUrl) async {
    var ref = FirebaseStorage.instance.ref();
    var fileName = imageUrl.substring(
        imageUrl.lastIndexOf("/") + 1, imageUrl.indexOf("?"));
    await ref.child(fileName).delete();
  }
}
