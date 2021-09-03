import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';

class ServicePostController extends GetxController {
  var servicePosts = [
    new ServicePost(
        serviceName: "Fixing a Tire",
        serviceType: "Garage",
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
        channelId: "g1"),
    new ServicePost(
        serviceName: "Fixing a Tire",
        serviceType: "Bolo-Service",
        price: 500,
        serviceDescription:
            "We will help you move your vehicle from one place to another",
        imageUrl: "assets/images/bolo1.jpg",
        tags: <String>[
          "Pickup",
          "Crane",
          "Mekina mansha",
          "t1",
        ],
        date: DateTime.now().toString(),
        channelId: "service"),
    new ServicePost(
        serviceName: "Fixing a Tire",
        serviceType: "Tow-Truck",
        price: 500,
        serviceDescription:
            "We will help you move your vehicle from one place to another",
        imageUrl: "assets/images/towtruck1.jpg",
        tags: <String>[
          "Pickup",
          "Crane",
          "Mekina mansha",
          "TowTruck",
        ],
        date: DateTime.now().toString(),
        channelId: "s1"),
  ];
  int getGarageServicePostsCount() {
    return servicePosts.length;
  }

  int getPostsCountByType(String type) {
    return servicePosts.where((post) => post.serviceType == type).length;
  }

  List<ServicePost> getPostsByType(String type) {
    return servicePosts.where((post) => post.serviceType == type).toList();
  }
}
