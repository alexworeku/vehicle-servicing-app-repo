import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoiceCallView extends StatelessWidget {
  final String imageUrl, name;
  const VoiceCallView({Key key, this.imageUrl, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Voice Call"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imageUrl),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: Get.theme.textTheme.headline6,
              ),
              SizedBox(
                height: 3,
              ),
              Text("2:39"),
              SizedBox(
                height: Get.height * 0.4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(icon: Icon(Icons.volume_up), onPressed: () {}),
                  IconButton(icon: Icon(Icons.volume_off), onPressed: () {}),
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: IconButton(
                          icon: Icon(Icons.call_end), onPressed: () {}))
                ],
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     CircleAvatar(
              //       radius: 30,
              //       backgroundColor: Color.fromRGBO(19, 175, 130, 1),
              //       child: IconButton(
              //         icon: Icon(Icons.call),
              //         onPressed: () {},
              //       ),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.0065,
              //     ),
              //     CircleAvatar(
              //       radius: 30,
              //       backgroundColor: Color.fromRGBO(243, 65, 83, 1),
              //       child: IconButton(
              //         icon: Icon(Icons.call_end),
              //         onPressed: () {},
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ));
  }
}
