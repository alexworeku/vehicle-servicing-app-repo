import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/signup_view.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/verify_phone_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Get.theme.colorScheme.onSurface,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
                radius: 40,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Welcome back",
                style: Get.theme.textTheme.headline4,
              ),
              Text(
                "Login to continue",
                style: Get.theme.textTheme.headline6,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter phone number"),
              ),
              
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 54,
                width: Get.width,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => VerifyPhoneView());
                    },
                    child: Text("Login")),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't have account ?",
                    style: Get.theme.textTheme.bodyText2,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.close(1);
                        Get.to(() => SignUpView());
                      },
                      child: Text("Create account"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
