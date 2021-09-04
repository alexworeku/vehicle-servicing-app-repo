import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iservice_repository.dart';

class ServicePostRepository implements IServiceRepository {
  @override
  Future<List<ServicePost>> getOwnedPosts(String type, String channelId) {
    // TODO: implement getOwnedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<ServicePost>> getPostsByType(String type) {
    // TODO: implement getPostsByType
    throw UnimplementedError();
  }
}
