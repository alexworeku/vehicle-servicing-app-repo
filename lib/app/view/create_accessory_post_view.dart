import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';

class CreateAccessoryPostView extends StatelessWidget {
  final TextEditingController _productNameController = TextEditingController(),
      _priceController = TextEditingController(),
      _brandController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _tagsController = TextEditingController();
  File selectedImage;
  Channel channel;
  CreateAccessoryPostView({Key key, @required this.channel}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name of the accessory";
                    }
                    return null;
                  },
                  controller: _productNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter name of the accessory",
                      labelText: "Name"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter price of the accessory";
                    }
                    return null;
                  },
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter price of the accessory",
                      labelText: "Price"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter brand of the accessory",
                      labelText: "Brand"),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter description about the accessory";
                          }
                          return null;
                        },
                        maxLines: 4,
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
                  controller: _tagsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tags",
                      hintText: "i.e #Radiator #Fan"),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () async {
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
                          AccessoryPost post = new AccessoryPost(
                              productName: _productNameController.text,
                              price: double.parse(_priceController.text),
                              brand: _brandController.text,
                              productDescription: _descriptionController.text,
                              imageUrl: downloadUrl,
                              tags: _tagsController.text.isNotEmpty
                                  ? _tagsController.text.trim().split("#")
                                  : <String>[_productNameController.text],
                              date: DateTime.now().toString(),
                              channelId: channel.id);
                          Get.find<AccessoryPostController>()
                              .addAccessoryPost(post);
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
                      },
                      child: Text("Create Post")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
