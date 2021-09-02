import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/user.dart';

class EditUserProfileView extends StatefulWidget {
  final User user;

  EditUserProfileView({Key key, this.user}) : super(key: key);

  @override
  _EditUserProfileViewState createState() => _EditUserProfileViewState();
}

class _EditUserProfileViewState extends State<EditUserProfileView> {
  final cities = <String>["Addis Abeba", "Adama", "Bahir Dar"];

  String selectedCity = "Adama";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(widget.user.profileImageUrl),
                  radius: 50,
                ),
                Positioned(
                    top: 65,
                    left: 65,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Full name"),
            ),
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                  hint: Text("City"),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  value: selectedCity,
                  items: cities
                      .map<DropdownMenuItem<String>>(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList()),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Save Changes"))
          ],
        ),
      ),
    );
  }
}
