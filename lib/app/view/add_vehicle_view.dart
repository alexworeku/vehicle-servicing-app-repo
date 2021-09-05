import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/vehicles_controller.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';

class AddVehicleView extends StatefulWidget {
  final String channelId;
  const AddVehicleView({Key key, @required this.channelId}) : super(key: key);

  @override
  _AddVehicleViewState createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  var _formKey = GlobalKey<FormState>();
  var plateNoController = TextEditingController(),
      typeController = TextEditingController(),
      modelController = TextEditingController(),
      ownerNameController = TextEditingController(),
      phoneController = TextEditingController(),
      descriptionController = TextEditingController();
  File selectedImage;
  String checkoutDate;
  String getFormatedDate(DateTime date) {
    return "${date.day.toString()}-${date.month.toString()}-${date.year.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Vehicle")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter plate no";
                    }
                    return null;
                  },
                  controller: plateNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter plate number of the vehicle",
                      labelText: "Plate No"),
                ),
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter vehicle type";
                    }
                    return null;
                  },
                  controller: typeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Vehicle Type",
                      hintText:
                          "Enter type of vehicle (i.e Minibus,Pickup...)"),
                ),
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  controller: modelController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Vehicle Model  (optional)",
                      hintText: "Enter model of the vehicle"),
                ),
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter owner name";
                    }
                    return null;
                  },
                  controller: ownerNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter vehicle owner's name",
                      labelText: "Owner's name"),
                ),
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter owner's phone number";
                    }
                    return null;
                  },
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter vehicle owner's phone number",
                      labelText: "Owner's phone"),
                ),
                SizedBox(
                  height: 11,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter vehicle description",
                      labelText: "Description (optional)"),
                ),
                SizedBox(
                  height: 11,
                ),
                ListTile(
                  onTap: () async {
                    var selectedDate = await showDatePicker(
                        context: Get.context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050));
                    if (selectedDate != null) {
                      checkoutDate = getFormatedDate(selectedDate);
                    }
                  },
                  title: Text("Set checkout date"),
                  trailing: Icon(Icons.date_range),
                ),
                SizedBox(
                  height: 11,
                ),
                ListTile(
                  onTap: () async {
                    var pickedImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 50);
                    if (pickedImage != null) {
                      selectedImage = new File(pickedImage.path);
                    }
                  },
                  title: Text("Browse picture"),
                  trailing: Icon(Icons.add_a_photo),
                ),
                SizedBox(
                  height: 11,
                ),
                SizedBox(
                    height: 54,
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Get.showSnackbar(GetBar(
                              title: "Adding...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));
                            var downloadUrl;
                            if (selectedImage != null) {
                              downloadUrl =
                                  await FirebaseStorageProvider.uploadImage(
                                      selectedImage);
                            }
                            Get.find<VehiclesController>().addVehicle(
                                new Vehicle(
                                    plateNo: plateNoController.text,
                                    type: typeController.text,
                                    model: modelController.text,
                                    description: descriptionController.text,
                                    ownerName: ownerNameController.text,
                                    ownerPhoneNumber: phoneController.text,
                                    imageUrl: downloadUrl,
                                    channelId: widget.channelId,
                                    checkInDate:
                                        getFormatedDate(DateTime.now()),
                                    checkOutDate: checkoutDate));
                            Get.close(1);
                            Get.showSnackbar(GetBar(
                                title: "Vehicle",
                                message: "Vehicle added successfully!",
                                duration: Duration(seconds: 3),
                                icon: Icon(Icons.car_repair)));
                          }
                        },
                        child: Text("Add")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
