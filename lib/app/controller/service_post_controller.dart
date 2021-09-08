import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iservice_repository.dart';

class ServicePostController extends GetxController {
  IServiceRepository _servicePostRepository;
  ServicePostController(this._servicePostRepository);

  void addServicePost(ServicePost post) async {
    await _servicePostRepository.add(post);
  }

  void removeServicePost(String postId) async {
    await _servicePostRepository.remove(postId);
  }

  Future<List<ServicePost>> getPostsByType(String type) async {
    return await _servicePostRepository.getPostsByType(type);
  }

  Future<List<ServicePost>> getPostsByTag(String tag) async {
    return _servicePostRepository.getPostsByTag(tag);
  }

  Future<List<ServicePost>> getOwnedPosts(String channelId, String type) async {
    return await _servicePostRepository.getOwnedPosts(type, channelId);
  }
}
