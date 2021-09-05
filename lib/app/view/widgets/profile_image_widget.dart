import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';

// ignore: must_be_immutable
class ProfileImageWidget extends StatefulWidget {
  String profileUrl;
  bool isChannelProfile;
  String channelId;
  bool isForAdmin;
  ProfileImageWidget(
      {Key key,
      this.profileUrl,
      this.isChannelProfile = false,
      this.isForAdmin = false,
      this.channelId})
      : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  Future<void> _pickAndUploadImage() async {
    var pickedImage = await ImagePicker()
        .pickImage(imageQuality: 50, source: ImageSource.gallery);
    if (pickedImage != null) {
      File selectedImage = new File(pickedImage.path);
      String downloadUrl;
      if (widget.profileUrl == null) {
        downloadUrl = await FirebaseStorageProvider.uploadImage(selectedImage);
      } else {
        downloadUrl = await FirebaseStorageProvider.uploadAndReplaceImage(
            selectedImage, widget.profileUrl);
      }
      if (widget.isChannelProfile) {
        Get.find<ChannelController>().updateChannelProfile(
            widget.channelId, "ProfileImageUrl", downloadUrl);
      } else {
        Get.find<UserController>()
            .updateUserOnly("ProfileImageUrl", downloadUrl);
      }

      setState(() {
        widget.profileUrl = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.profileUrl != null
            ? CachedNetworkImage(
                imageUrl: widget.profileUrl,
                placeholder: (ctx, imgProvider) =>
                    SpinKitCircle(color: Get.theme.primaryColor),
                errorWidget: (ctx, url, error) => Icon(Icons.error),
                imageBuilder: (ctx, imgProvider) {
                  return CircleAvatar(radius: 50, backgroundImage: imgProvider);
                },
              )
            : CircleAvatar(
                radius: 50,
                child: Icon(Icons.person),
              ),
        Positioned(
            top: 65,
            left: 65,
            child: widget.isForAdmin
                ? IconButton(
                    onPressed: () async {
                      await _pickAndUploadImage();
                    },
                    icon: Icon(Icons.add_a_photo),
                  )
                : Container())
      ],
    );
  }
}
