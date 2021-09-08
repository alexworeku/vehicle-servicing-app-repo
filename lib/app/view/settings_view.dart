import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/view/edit_user_profile_view.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: Get.height,
        child: Obx(() => Get.find<UserController>().isLoggedIn.value
            ? ListView(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Edit profile"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.to(() => EditUserProfileView());
                    },
                  ),
                  Divider(),
                  SwitchListTile(
                    title: Text("Dark Mode"),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () async {
                          await Get.find<UserController>().signOut();

                          Get.back();
                        },
                        child: Text("Logout")),
                  )
                ],
              )
            : Center(child: Text("Please sign in first!"))),
      ),
    );
  }
}
