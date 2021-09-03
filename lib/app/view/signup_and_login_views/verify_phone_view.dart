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
                  style: Get.theme.textTheme.headline6,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "We have sent you an sms with a code.",
                  style: Get.theme.textTheme.bodyText1,
                ),
                SizedBox(height: Get.height * 0.05),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter sms code"),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () {
                        //TO HomeView
                        Get.close(1);
                        Get.to(() => HomeView());
                      },
                      child: Text("Verify")),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
