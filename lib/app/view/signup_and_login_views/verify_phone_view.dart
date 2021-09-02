import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/view/home_view.dart';

class VerifyPhoneView extends StatelessWidget {
  const VerifyPhoneView({Key key}) : super(key: key);

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
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone verification",
                  style: Get.theme.textTheme.headline4,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "We have sent you an sms with a code.",
                  style: Get.theme.textTheme.subtitle2,
                ),
                SizedBox(height: Get.height * 0.1),
                TextFormField(
                  decoration: InputDecoration(labelText: "Enter sms code"),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't recieve SMS ?",
                      style: Get.theme.textTheme.subtitle2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(onPressed: () {}, child: Text("Resend Code"))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      //TO HomeView
                      Get.close(1);
                      Get.to(() => HomeView());
                    },
                    child: Text("Verify"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
