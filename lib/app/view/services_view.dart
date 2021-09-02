import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ServicesView extends StatelessWidget {
  final String typeOfService;
  final controller = Get.put(new ServicePostController());

  ServicesView({Key key, this.typeOfService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(typeOfService, style: Get.theme.textTheme.headline6),
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(left: 10, right: 10),
          itemCount: controller.getGarageServicePostsCount(),
          itemBuilder: (ctx, index) {
            var posts = controller.getGarageServicePosts();
            return ServicePostCardWidget(servicePost: posts[index]);
          }),
    );
  }
}
