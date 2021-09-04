import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';

import 'package:vehicleservicingapp/app/view/signup_and_login_views/login_view.dart';
import 'package:vehicleservicingapp/app/view/signup_and_login_views/verify_phone_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController(),
      _phoneController = new TextEditingController();
  var cities = <String>["Addis Abeba", "Adama", "Bahir Dar"];

  @override
  Widget build(BuildContext context) {
    var _selectedCity = cities[0];
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
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign up",
                  style: Get.theme.textTheme.headline4,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Join our platform by creating a new account",
                  style: Get.theme.textTheme.headline6,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Full name")),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone number")),
                SizedBox(
                  height: 12,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_history),
                  ),
                  value: _selectedCity,
                  onChanged: (selectedValue) {
                    setState(() {
                      _selectedCity = selectedValue;
                    });
                  },
                  validator: (newValue) {
                    return null;
                  },
                  items: cities
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 54,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        AppUser user = new AppUser(
                            phoneNo: _phoneController.text.trim(),
                            city: _selectedCity,
                            fullName: _nameController.text);
                        var userController = Get.find<UserController>();
                        await userController.verifyUserByPhone(user);
                      },
                      child: Text("Create Account")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: Get.theme.textTheme.subtitle2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.close(1);
                          Get.to(() => LoginView());
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
