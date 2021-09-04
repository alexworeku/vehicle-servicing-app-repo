import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iuser_repository.dart';
import 'package:vehicleservicingapp/app/view/home_view.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/verify_phone_view.dart';

class UserController extends GetxController {
  IUserRepository userRepository;
  var isLoggedIn = false.obs;

  UserController({@required this.userRepository}) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      isLoggedIn.value = user != null;
      debugPrint("State Changed to" + isLoggedIn.value.toString());
    });
  }
  List<String> getAvailableCities() {
    return <String>["Addis Abeba", "Adama", "Bahir Dar"];
  }

  void updateUser(AppUser user) async {
    await userRepository.update(getCurrentUserId(), user);
  }

  void updateUserOnly(String fieldName, dynamic newValue) async {
    await userRepository.updateOnly(getCurrentUserId(), fieldName, newValue);
  }

  Future<AppUser> getCurrentUser() async {
    return await userRepository.get(getCurrentUserId());
  }

  String getCurrentUserId() {
    String id = FirebaseAuth.instance.currentUser.uid;
    return id;
  }

  Future<AppUser> getUserById(String id) async {
    return await userRepository.get(id);
  }

  Future<bool> isUserRegistered(String phoneNumber) async {
    return await userRepository.existsByPhone(phoneNumber);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> verifyUserByPhone(AppUser appUser) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: appUser.phoneNo,
        verificationCompleted: (authCredential) async {
          var user = await auth.signInWithCredential(authCredential);
          if (user != null) {
            appUser.id = auth.currentUser.uid;
            if (!(await userRepository.existsById(auth.currentUser.uid))) {
              await userRepository.add(appUser);
            }
            Get.to(() => HomeView());
          }
        },
        verificationFailed: (exception) {
          debugPrint("phone verification error, " + exception.message);
        },
        codeSent: (verificationCode, resendToken) {
          debugPrint("In Code Sent");

          Get.to(() =>
              VerifyPhoneView(onSmsCodeEntered: (enteredSmsCode) async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationCode, smsCode: enteredSmsCode);
                var userCredential =
                    await auth.signInWithCredential(credential);
                if (userCredential != null) {
                  appUser.id = auth.currentUser.uid;
                  var userExists = await userRepository.existsById(appUser.id);
                  if (!userExists) {
                    await userRepository.add(appUser);
                  }
                  Get.to(() => HomeView());
                }
              }));
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
