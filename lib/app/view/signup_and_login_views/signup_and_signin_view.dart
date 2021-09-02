import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vehicleservicingapp/app/view/signup_and_login_views/signup_view.dart';

class SignUpAndSignInView extends StatelessWidget {
  const SignUpAndSignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bk_image.jpg"),
                  fit: BoxFit.contain),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.9, 50),
                    ),
                    onPressed: () {
                      Get.to(() => SignUpView());
                    },
                    child: Text("Sign up"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.9, 50),
                    ),
                    onPressed: () {},
                    child: Text("Login"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
