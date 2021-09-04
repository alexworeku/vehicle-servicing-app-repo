import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_user.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/view/widgets/profile_image_widget.dart';

class EditUserProfileView extends StatefulWidget {
  EditUserProfileView({Key key}) : super(key: key);

  @override
  _EditUserProfileViewState createState() => _EditUserProfileViewState();
}

class _EditUserProfileViewState extends State<EditUserProfileView> {
  var selectedCity = "Adama";
  final _formKey = GlobalKey<FormState>();
  File selectedImage;
  final nameController = new TextEditingController();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: FutureBuilder<AppUser>(
        future: userController.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong!"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            nameController.text = snapshot.data.fullName;
            selectedCity = snapshot.data.city;
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileImageWidget(
                      profileUrl: snapshot.data.profileImageUrl,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Full name"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          hint: Text("City"),
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          value: selectedCity,
                          items: userController
                              .getAvailableCities()
                              .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem<String>(
                                    value: e, child: Text(e)),
                              )
                              .toList()),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 54,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              userController.updateUser(new AppUser(
                                fullName: nameController.text,
                                city: selectedCity,
                              ));
                              Get.showSnackbar(GetBar(
                                duration: Duration(seconds: 3),
                                title: "Profile Updated",
                                message:
                                    "Your profile has been updated successfully.",
                                icon: Icon(Icons.person),
                              ));
                            }
                          },
                          child: Text("Save Changes")),
                    )
                  ],
                ),
              ),
            );
          }
          return SpinKitCircle(
            color: Get.theme.primaryColor,
          );
        },
      ),
    );
  }
}
