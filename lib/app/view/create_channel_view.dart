import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';

class CreateChannelView extends StatefulWidget {
  final bool showEditForm;
  final Channel channel;
  CreateChannelView({Key key, this.showEditForm = false, this.channel})
      : super(key: key);

  @override
  _CreateChannelViewState createState() => _CreateChannelViewState();
}

class _CreateChannelViewState extends State<CreateChannelView> {
  final _formKey = GlobalKey<FormState>();
  String selectedChannelType = "Service";
  String selectedCity = "Addis Abeba";
  bool locationSelected = true;
  @override
  Widget build(BuildContext context) {
    print(Get.find<ChannelController>().getChannelTypes());
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
                TextField(
                  decoration: InputDecoration(labelText: "Channel Name"),
                ),
                widget.showEditForm
                    ? Container()
                    : DropdownButton<String>(
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
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Phone number"),
                ),
                SizedBox(
                  height: 12,
                ),
                DropdownButton<String>(
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
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(labelText: "Channel description"),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child:
                        Text(widget.showEditForm ? "Save Changes" : "Create"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
