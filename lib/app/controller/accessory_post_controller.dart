import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

class AccessoryPostController extends GetxController {
  var products = [
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo1.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo2.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/article2.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/product2.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Tire",
        price: 5000,
        brand: "Toyota",
        productDescription:
            "Its a good productIts a good productIts a good productIts a good productIts a good product",
        imageUrl: "assets/images/article1.jpg",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo1.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo2.jpg",
        productDescription: "Its a good product",
        tags: ["Chansii", "Ye taxi", "Body"],
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/article2.jpg",
        tags: ["Chansii", "Ye taxi", "Body"],
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
  ];

  List<AccessoryPost> getAllPosts() {
    return products;
  }

  int getPostsCount() {
    return products.length;
  }
}
