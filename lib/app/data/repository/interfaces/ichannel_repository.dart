import 'package:vehicleservicingapp/app/data/model/channel.dart';

abstract class IChannelRepository {
  Future<Channel> get(String id);
  Future<void> add(Channel channel);
  Future<void> update(String id, Channel channel);
  Future<void> updateOnly(String id, String field, dynamic newValue);
  Future<void> remove(String channelId);
  Future<List<Channel>> getAllByUserId(String userId);
  Future<List<Channel>> getTopRated(String type, int limit);
  Future<List<Channel>> getNearBy(String type);
  Future<void> addTestimonial(String channelId, String message);
  Future<void> addRating(String channelId, dynamic value);
}
