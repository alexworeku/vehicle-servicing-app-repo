import 'package:vehicleservicingapp/app/data/model/app_user.dart';

abstract class IUserRepository {
  Future<void> add(AppUser user);
  Future<void> update(String id, AppUser user);
  Future<void> updateOnly(String id, String field, dynamic newValue);
  Future<AppUser> get(String id);
  Future<bool> existsById(String id);
  Future<AppUser> getUserByPhoneNumber(String phone);
  Future<bool> existsByPhone(String phoneNumber);
}
