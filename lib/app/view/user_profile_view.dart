import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/user.dart';

class UserProfileView extends StatelessWidget {
  final User user;
  const UserProfileView({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                //TODO:OPen Default Phone App
              }),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(user.profileImageUrl),
              radius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.fullName,
              style: Get.theme.textTheme.headline5,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  user.phoneNo,
                  style: Get.theme.textTheme.headline6,
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(user.city),
              ],
            )
          ],
        ),
      ),
    );
  }
}
