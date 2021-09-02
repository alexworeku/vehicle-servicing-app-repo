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
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo2.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/article2.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/product2.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Tire",
        price: 5000,
        brand: "Toyota",
        productDescription: "Its a good product",
        imageUrl: "assets/images/article1.jpg",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo1.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/bolo2.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
    AccessoryPost(
        productName: "Chansii",
        price: 5000,
        brand: "Toyota",
        imageUrl: "assets/images/article2.jpg",
        productDescription: "Its a good product",
        date: DateTime.now().toString()),
  ];

  int getPostsCount() {
    return products.length;
  }

  List<AccessoryPost> getAllPosts() {
    return products;
  }
}
