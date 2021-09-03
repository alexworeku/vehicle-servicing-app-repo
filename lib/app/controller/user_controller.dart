import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/user.dart';

class UserController extends GetxController {
  User get currentUser => User(
        fullName: "Alex Woreku",
        city: "Addis abeba",
        phoneNo: "+251913662761",
        profileImageUrl: "assets/images/bk 2.jpg",
      );

  User getUserWith(String userId) {
    return currentUser;
  }

  bool isLoggedIn() {
    return false;
  }
}
