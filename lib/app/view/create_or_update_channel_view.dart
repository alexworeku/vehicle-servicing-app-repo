import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';

class CreateOrUpdateChannelView extends StatefulWidget {
  final bool showEditForm;
  final Channel channel;
  CreateOrUpdateChannelView({Key key, this.showEditForm = false, this.channel})
      : super(key: key);

  @override
  _CreateOrUpdateChannelViewState createState() =>
      _CreateOrUpdateChannelViewState();
}

class _CreateOrUpdateChannelViewState extends State<CreateOrUpdateChannelView> {
  final _formKey = GlobalKey<FormState>();
  String selectedChannelType = "Garage";
  String selectedCity = "Addis Abeba";
  bool locationSelected = true;
  final nameController = new TextEditingController(),
      phoneController = new TextEditingController(),
      descController = new TextEditingController();
  final channelController = Get.find<ChannelController>();
  @override
  Widget build(BuildContext context) {
    if (widget.showEditForm) {
      nameController.text = widget.channel.channelName;
      phoneController.text = widget.channel.phoneNum;
      descController.text = widget.channel.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showEditForm ? "Edit Channel" : "Create Channel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Channel name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Channel Name"),
                ),
                SizedBox(
                  height: 12,
                ),
                widget.showEditForm
                    ? Container()
                    : DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Channel Type"),
                        value: selectedChannelType,
                        onChanged: (value) {
                          setState(() {
                            selectedChannelType = value;
                          });
                        },
                        items: Get.find<ChannelController>()
                            .getChannelTypes()
                            .map<DropdownMenuItem<String>>(
                              (String e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList()),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Phone number"),
                ),
                SizedBox(
                  height: 12,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCity,
                  hint: Text("Buisness Placement"),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  items: <String>["Addis Abeba", "Adama", "Bahir Dar"]
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: descController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some desciption about your channel";
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Channel description"),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 54,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (widget.showEditForm) {
                            //Update
                            Get.showSnackbar(GetBar(
                              title: "Updating...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));
                            await channelController.updateChannel(
                              widget.channel.id,
                              new Channel(
                                  channelName: nameController.text,
                                  channelType: selectedChannelType,
                                  description: descController.text,
                                  rating: widget.channel.rating,
                                  imageUrl: widget.channel.imageUrl,
                                  city: selectedCity,
                                  phoneNum: phoneController.text,
                                  testimonials: <String>[],
                                  userId: Get.find<UserController>()
                                      .getCurrentUserId()),
                            );
                            Get.close(1);
                            Get.showSnackbar(GetBar(
                              duration: Duration(seconds: 3),
                              title: "Channel Updated",
                              message: "Channel have been updated",
                              icon: Icon(Icons.chat),
                            ));
                          } else {
                            //Add new
                            Get.showSnackbar(GetBar(
                              title: "Adding...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));
                            await channelController.addNewChannel(
                              new Channel(
                                  channelName: nameController.text,
                                  channelType: selectedChannelType,
                                  description: descController.text,
                                  city: selectedCity,
                                  rating: [],
                                  phoneNum: phoneController.text,
                                  testimonials: <String>[],
                                  userId: Get.find<UserController>()
                                      .getCurrentUserId()),
                            );
                            Get.close(1);
                            Get.showSnackbar(GetBar(
                              duration: Duration(seconds: 3),
                              title: "Channel Created",
                              message: "New Channel have been created",
                              icon: Icon(Icons.chat),
                            ));
                          }
                        }
                      },
                      child: Text(
                          widget.showEditForm ? "Save Changes" : "Create")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
