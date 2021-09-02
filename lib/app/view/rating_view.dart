import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingView extends StatefulWidget {
  RatingView({Key key}) : super(key: key);

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  int rating = 1;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Get.close(1);
                      }),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (index) {
                      return IconButton(
                          icon: Icon(
                            Icons.star,
                            color: index + 1 <= rating
                                ? Colors.orangeAccent
                                : Get.theme.iconTheme.color,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          });
                    })),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Rate"))
              ],
            ),
          )),
    );
  }
}
