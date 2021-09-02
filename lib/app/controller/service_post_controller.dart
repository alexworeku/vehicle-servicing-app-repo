import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';

class ServicePostController extends GetxController {
  var servicePosts = [
    new ServicePost(
        serviceName: "Tow-Truck",
        price: 500,
        serviceDescription:
            "We will help you move your vehicle from one place to another",
        imageUrl: "assets/images/garage1.jpg",
        tags: <String>[
          "Pickup",
          "Crane",
          "Mekina mansha",
          "TowTruck",
        ],
        date: DateTime.now().toString(),
        channelId: "service")
  ];
  int getGarageServicePostsCount() {
    return servicePosts.length;
  }

  List<ServicePost> getGarageServicePosts() {
    return servicePosts;
  }
}
