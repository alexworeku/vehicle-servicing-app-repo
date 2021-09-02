import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiveTestimonialView extends StatelessWidget {
  const GiveTestimonialView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testimonial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "What do you think about the channel?",
              style: Get.theme.textTheme.headline6,
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Comment"),
              maxLines: 4,
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Post"))
          ],
        ),
      ),
    );
  }
}
