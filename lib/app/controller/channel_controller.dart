import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';

import 'package:vehicleservicingapp/app/data/repository/interfaces/ichannel_repository.dart';

class ChannelController extends GetxController {
  IChannelRepository _channelRepository;
  ChannelController(this._channelRepository);
  List<String> getChannelTypes() {
    return ["Garage", "Accessory", "Tow-Truck", "Bolo-Service", "Blog", "Blog"];
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

  Future<Channel> getChannelById(String channelId) {
    return _channelRepository.get(channelId);
  }

  void removeChannel(String channelId) async {
    await _channelRepository.remove(channelId);
  }

  void updateChannelProfile(String channelId, String newValue) async {
    await _channelRepository.updateOnly(channelId, "ProfileImageUrl", newValue);
  }

  void addTestimonial(String channelId, String comment) async {
    await _channelRepository.addTestimonial(channelId, comment);
  }
}
