import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateArticlePostView extends StatelessWidget {
  CreateArticlePostView({Key key}) : super(key: key);

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
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(labelText: "Content"),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {})
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Duration"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: "Tags", hintText: "i.e #RadiatorFix"),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Post"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
