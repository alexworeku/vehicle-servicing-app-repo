import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';

class GiveTestimonialView extends StatefulWidget {
  final String channelId;
  const GiveTestimonialView({Key key, @required this.channelId})
      : super(key: key);

  @override
  _GiveTestimonialViewState createState() => _GiveTestimonialViewState();
}

class _GiveTestimonialViewState extends State<GiveTestimonialView> {
  var _formKey = GlobalKey<FormState>();
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Get.theme.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "What do you think about the channel?",
                  style: Get.theme.textTheme.headline6,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: commentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write something first";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Comment"),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: Get.width,
                    height: 54,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.find<ChannelController>().addTestimonial(
                              widget.channelId, commentController.text);
                          Get.showSnackbar(GetBar(
                            duration: Duration(seconds: 3),
                            title: "Commnt posted!",
                            message: "Thank you for your feedback",
                            icon: Icon(Icons.comment),
                          ));
                        },
                        child: Text("Post")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
