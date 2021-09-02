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
              Text(
                "Welcome Back",
                style: Get.theme.textTheme.headline4,
              ),
              Text(
                "Login to continue",
                style: Get.theme.textTheme.headline6,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Phone number"),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => VerifyPhoneView());
                  },
                  child: Text("Login")),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't have account ?",
                    style: Get.theme.textTheme.subtitle2,
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
