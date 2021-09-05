import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';

class CreateArticlePostView extends StatefulWidget {
  final String channelId;

  CreateArticlePostView({Key key, @required this.channelId}) : super(key: key);

  @override
  _CreateArticlePostViewState createState() => _CreateArticlePostViewState();
}

class _CreateArticlePostViewState extends State<CreateArticlePostView> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(),
      contentController = TextEditingController(),
      durationController = TextEditingController(),
      tagController = TextEditingController();
  File selectedImage;
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
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter title of the article";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter title for the article",
                      labelText: "Title"),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: contentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter main content of the article";
                          }
                          return null;
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "What do you want to share?",
                            labelText: "Content"),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () async {
                          var pickedImage = await new ImagePicker().pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          if (pickedImage != null) {
                            selectedImage = File(pickedImage.path);
                          }
                        })
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: durationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid minute  i.e 5";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "i.e 5",
                      labelText: "Duration"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: tagController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tags",
                      hintText: "i.e #RadiatorFix#EngineFix"),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (selectedImage != null) {
                            Get.showSnackbar(GetBar(
                              title: "Creating...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));

                            var downloadUrl =
                                await FirebaseStorageProvider.uploadImage(
                                    selectedImage);
                            Get.find<ArticlePostController>().addArticlePost(
                                new ArticlePost(
                                    title: titleController.text,
                                    duration:
                                        int.parse(durationController.text),
                                    content: contentController.text,
                                    likes: 0,
                                    channelId: widget.channelId,
                                    imageUrl: downloadUrl,
                                    tags: tagController.text.isNotEmpty
                                        ? tagController.text.trim().split("#")
                                        : <String>[titleController.text]));

                            Get.close(1);
                            Get.showSnackbar(GetBar(
                              title: "Create post",
                              message: "Post created successfully",
                              icon: Icon(Icons.verified),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetBar(
                              title: "Create post",
                              message: "Please select image",
                              icon: Icon(Icons.add_a_photo),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }
                      },
                      child: Text("Post")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
