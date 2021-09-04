import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iuser_repository.dart';

class UserRepository implements IUserRepository {
  @override
  Future<void> add(AppUser user) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.id)
        .set(user.toMap());
  }

  @override
  Future<AppUser> get(String id) async {
    var docSnapShot =
        await FirebaseFirestore.instance.collection("Users").doc(id).get();
    return AppUser.fromMap(docSnapShot.data());
  }

  @override
  Future<void> update(String id, AppUser user) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .update({'City': user.city, 'FullName': user.fullName});
  }

  @override
  Future<bool> existsById(String id) async {
    var result =
        await FirebaseFirestore.instance.collection("Users").doc(id).get();
    return result.exists;
  }

  @override
  Future<bool> existsByPhone(String phoneNumber) async {
    var result = await FirebaseFirestore.instance
        .collection("Users")
        .where("PhoneNumber", isEqualTo: phoneNumber)
        .get();

    return result.size != 0;
  }

  @override
  Future<void> updateOnly(String id, String field, newValue) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .update({field: newValue});
  }
}
