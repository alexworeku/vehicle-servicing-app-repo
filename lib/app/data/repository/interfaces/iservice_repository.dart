import 'dart:developer';

import 'package:vehicleservicingapp/app/data/model/service_post.dart';

abstract class IServiceRepository {
  Future<void> add(ServicePost post);
  Future<void> remove(String id);
  Future<List<ServicePost>> getPostsByTag(String tag);
  Future<List<ServicePost>> getPostsByType(String type);

  Future<List<ServicePost>> getOwnedPosts(String type, String channelId);
}
