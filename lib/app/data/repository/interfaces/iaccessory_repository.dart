import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

abstract class IAccessoryRepository {
  Future<void> add(AccessoryPost post);
  Future<void> remove(String id);
  Future<List<AccessoryPost>> getAll();
  Future<List<AccessoryPost>> getTop(int limit);
  Future<List<AccessoryPost>> getAllByTag(String tag);
  Future<List<AccessoryPost>> getOwnedPosts(String channelId);
}
