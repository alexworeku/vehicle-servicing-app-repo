import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

import 'package:vehicleservicingapp/app/data/repository/interfaces/iaccessory_repository.dart';

class AccessoryPostController extends GetxController {
  IAccessoryRepository _accessoryRepository;
  AccessoryPostController(this._accessoryRepository);

  void addAccessoryPost(AccessoryPost post) async {
    await _accessoryRepository.add(post);
  }

  void removeAccessoryPost(String id) async {
    await _accessoryRepository.remove(id);
  }

  Future<List<AccessoryPost>> getOwnedPosts(String channelId) async {
    return await _accessoryRepository.getOwnedPosts(channelId);
  }

  Future<List<AccessoryPost>> getAllPosts() async {
    return await _accessoryRepository.getAll();
  }

  Future<List<AccessoryPost>> getTopPosts() async {
    return await _accessoryRepository.getTop(10);
  }
}
