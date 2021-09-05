import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';

import 'package:vehicleservicingapp/app/data/repository/interfaces/ichannel_repository.dart';

class ChannelController extends GetxController {
  IChannelRepository _channelRepository;
  ChannelController(this._channelRepository);
  List<String> getChannelTypes() {
    return ["Garage", "Accessory", "Tow-Truck", "Bolo-Service", "Blog"];
  }

  void addRating(String channelId, dynamic ratingValue) async {
    await _channelRepository.addRating(channelId, ratingValue);
  }

  Future<void> addNewChannel(Channel channel) async {
    await _channelRepository.add(channel);
  }

  Future<void> updateChannel(String channelId, Channel channel) async {
    await _channelRepository.update(channelId, channel);
  }

  Future<List<Channel>> getOwnedChannels() {
    return _channelRepository
        .getAllByUserId(Get.find<UserController>().getCurrentUserId());
  }

  Future<List<Channel>> getTopRated(String type, int limit) {
    return _channelRepository.getTopRated(type, limit);
  }

  Future<Channel> getChannelById(String channelId) async {
    return _channelRepository.get(channelId);
  }

  void removeChannel(String channelId) async {
    await _channelRepository.remove(channelId);
  }

  void updateChannelProfile(
      String channelId, String field, dynamic newValue) async {
    await _channelRepository.updateOnly(channelId, field, newValue);
  }

  void addTestimonial(String channelId, String comment) async {
    await _channelRepository.addTestimonial(channelId, comment);
  }
}
