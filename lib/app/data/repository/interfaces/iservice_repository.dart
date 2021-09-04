import 'dart:developer';

import 'package:vehicleservicingapp/app/data/model/service_post.dart';

abstract class IServiceRepository {
  Future<List<ServicePost>> getPostsByType(String type);
  Future<List<ServicePost>> getOwnedPosts(String type, String channelId);
}
