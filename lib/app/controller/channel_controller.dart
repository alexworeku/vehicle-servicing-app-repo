import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/post.dart';

import 'package:vehicleservicingapp/app/data/model/service_post.dart';

class ChannelController extends GetxController {
  var _ownedChannels = <Channel>[
    new Channel(
        id: "article",
        channelName: "ABC PLC.",
        channelType: "Article",
        city: "Addis abeba",
        phoneNum: 0913662761,
        rating: 2.7,
        imageUrl: "assets/images/garage_bk.jpeg",
        description:
            "Hello, welcome to my channel i am a vehicle maintenance proffesional who want to share my knowledge",
        testimonials: <String>[
          "Good Job!",
          "Keep it up",
          "Keep it up",
        ],
        userId: "alex"),
    new Channel(
        id: "accessory",
        channelName: "HAHU ",
        channelType: "Accessory",
        city: "Addis abeba",
        phoneNum: 0913662761,
        rating: 1.0,
        imageUrl: "assets/images/garage_bk.jpeg",
        description:
            "sadddddddddddddddddddddddddddddddddddddsadsanewlmmlmfslkdfslflkmdsflkjwioeqjqwoejqwjjas;dj;;jjadk",
        testimonials: <String>[
          "Good Job!",
          "Keep it up",
          "Keep it up",
        ],
        userId: "alex"),
    new Channel(
        id: "service",
        channelName: "ABC PLC.",
        channelType: "Service",
        city: "Addis abeba",
        phoneNum: 0913662761,
        rating: 5.0,
        imageUrl: "assets/images/garage_bk.jpeg",
        description:
            "sadddddddddddddddddddddddddddddddddddddsadsanewlmmlmfslkdfslflkmdsflkjwioeqjqwoejqwjjas;dj;;jjadk",
        testimonials: <String>[
          "Good Job!",
          "Keep it up",
          "Keep it up",
        ],
        userId: "alex"),
  ];
  List<Post> get _posts => <Post>[
        new AccessoryPost(
            productName: "Car Oil",
            price: 2500,
            brand: "Italy",
            productDescription: "Its a great product.it can last longer",
            imageUrl: "assets/images/garage_bk.jpeg",
            date: DateTime.now().toString(),
            channelId: "accessory"),
        new AccessoryPost(
            productName: "Car Oil",
            price: 2500,
            brand: "Italy",
            productDescription: "Its a great product.it can last longer",
            imageUrl: "assets/images/garage_bk.jpeg",
            date: DateTime.now().toString(),
            channelId: "accessory"),
        new ArticlePost(
            title:
                "How to fix a flat Tire How to fix a flat TireHow to fix a flat TireHow to fix a flat Tire",
            duration: 3500,
            likes: 20,
            content:
                "In order to fix a flat tire please follow the following steps\n1.dsaadadasd\n2.adsdsaadsad\n3,dsadsaadsas",
            imageUrl: "assets/images/garage_bk.jpeg",
            tags: <String>[
              "Pickup",
              "Crane",
              "Mekina mansha",
              "TowTruck",
            ],
            date: DateTime.now().toString(),
            channelId: "article"),
        new ArticlePost(
            title: "How to fix a flat Tire",
            duration: 5,
            likes: 20,
            content:
                "In order to fix a flat tire please follow the following steps\n1.dsaadadasd\n2.adsdsaadsad\n3,dsadsaadsas",
            imageUrl: "assets/images/garage_bk.jpeg",
            tags: <String>[
              "Pickup",
              "Crane",
              "Mekina mansha",
              "TowTruck",
            ],
            date: DateTime.now().toString(),
            channelId: "article"),
        new ServicePost(
            serviceName: "Tow-Truck",
            price: 500,
            serviceDescription:
                "We will help you move your vehicle from one place to another",
            imageUrl: "assets/images/garage_bk.jpeg",
            tags: <String>[
              "Pickup",
              "Crane",
              "Mekina mansha",
              "TowTruck",
            ],
            date: DateTime.now().toString(),
            channelId: "service"),
        new ServicePost(
            serviceName: "Tow-Truck",
            price: 500,
            serviceDescription:
                "We will help you move your vehicle from one place to another",
            imageUrl: "assets/images/garage_bk.jpeg",
            tags: <String>[
              "Pickup",
              "Crane",
              "Mekina mansha",
              "TowTruck",
            ],
            date: DateTime.now().toString(),
            channelId: "service"),
        new ServicePost(
            serviceName: "Tow-Truck",
            price: 500,
            serviceDescription:
                "We will help you move your vehicle from one place to another",
            imageUrl: "assets/images/garage_bk.jpeg",
            tags: <String>[
              "Pickup",
              "Crane",
              "Mekina mansha",
              "TowTruck",
            ],
            date: DateTime.now().toString(),
            channelId: "service"),
      ];

  List<Channel> get channels => _ownedChannels;
  int get channelsCount => _ownedChannels.length;
  List<Post> getPosts(String cId) {
    return _posts.where((element) => element.channelId == cId).toList();
  }

  List<Channel> getGarageChannels() {
    return [
      Channel(
          imageUrl: "assets/images/garage1.jpg",
          channelName: "Fix it. Garage",
          rating: 2.5,
          city: "Gonder"),
      Channel(
          imageUrl: "assets/images/garage2.jpg",
          channelName: "Fix it. Garage",
          city: "Mekele",
          rating: 2.5),
      Channel(
          imageUrl: "assets/images/garage3.jpg",
          channelName: "Fix it. Garage",
          rating: 2.5,
          city: "Addis Abeba"),
      Channel(
          imageUrl: "assets/images/garage1.jpg",
          channelName: "Fix it. Garage",
          city: "Adama",
          rating: 2.5),
    ];
  }

  List<Channel> getBoloServiceProviderChannel() {
    return [
      Channel(
          imageUrl: "assets/images/bolo1.jpg",
          channelName: "Check it. Insp. Tech.",
          rating: 4.5,
          city: "Addis Abeba"),
      Channel(
          imageUrl: "assets/images/bolo2.jpg",
          channelName: "Check it. Insp. Tech.",
          rating: 4.5,
          city: "Addis Abeba"),
      Channel(
          imageUrl: "assets/images/bolo1.jpg",
          channelName: "Check it. Insp. Tech.",
          rating: 4.5,
          city: "Addis Abeba"),
    ];
  }

  List<Channel> getTowtruckChannels() {
    return [
      Channel(
          imageUrl: "assets/images/towtruck1.jpg",
          channelName: "Pick it. Crane",
          rating: 4.5,
          city: "Addis Abeba"),
      Channel(
          imageUrl: "assets/images/towtruck2.jpg",
          channelName: "Pick it. Crane",
          rating: 3.5,
          city: "Adama"),
      Channel(
          imageUrl: "assets/images/towtruck1.jpg",
          channelName: "Pick it. Crane",
          rating: 5.0,
          city: "Mekele"),
      Channel(
          imageUrl: "assets/images/towtruck2.jpg",
          channelName: "Pick it. Crane",
          rating: 3.0,
          city: "Gonder"),
    ];
  }

  int getPostsCount(String id) {
    return getPosts(id).length;
  }

  List<String> getChannelTypes() {
    return <String>["Service", "Accessory", "Article"];
  }

  Future<Channel> getChannelById(String channelId) async {
    return _ownedChannels[0];
  }
}
