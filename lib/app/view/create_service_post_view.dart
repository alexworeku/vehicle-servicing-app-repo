import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';

class CreateServicePostView extends StatefulWidget {
  Channel channel;
  CreateServicePostView({Key key, @required this.channel}) : super(key: key);

  @override
  _CreateServicePostViewState createState() => _CreateServicePostViewState();
}

class _CreateServicePostViewState extends State<CreateServicePostView> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(),
      priceController = TextEditingController(),
      descController = TextEditingController(),
      tagController = TextEditingController();
  File selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name of the  service";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Service name"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter price for the service";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Price"),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 4,
                        controller: descController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please write description of the service";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Description"),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () async {
                          var pickedImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          if (pickedImage != null) {
                            selectedImage = new File(pickedImage.path);
                          }
                        })
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: tagController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tags",
                      hintText: "i.e #Garage #ጋራጅ"),
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
                          if (selectedImage != null) {
                            Get.showSnackbar(GetBar(
                              title: "Creating...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));
                            String downloadUrl =
                                await FirebaseStorageProvider.uploadImage(
                                    selectedImage);
                            Get.find<ServicePostController>().addServicePost(
                                new ServicePost(
                                    serviceName: nameController.text,
                                    price: double.parse(priceController.text),
                                    serviceDescription: descController.text,
                                    imageUrl: downloadUrl,
                                    date: DateTime.now().toString(),
                                    tags: tagController.text.isNotEmpty
                                        ? tagController.text.trim().split("#")
                                        : <String>[nameController.text],
                                    serviceType: widget.channel.channelType,
                                    channelId: widget.channel.id));
                            Get.close(1);
                            Get.showSnackbar(GetBar(
                              title: "Create post",
                              message: "Post created successfully",
                              icon: Icon(Icons.verified),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetBar(
                              title: "Create post",
                              message: "Please select image",
                              icon: Icon(Icons.add_a_photo),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }
                      },
                      child: Text("Post")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
