import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ServicesView extends StatelessWidget {
  final String serviceType;
  final controller = Get.put(new ServicePostController());

  ServicesView({Key key, this.serviceType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType, style: Get.theme.textTheme.headline6),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(left: 10, right: 10),
          itemCount: controller.getPostsCountByType(serviceType),
          itemBuilder: (ctx, index) {
            var posts = controller.getPostsByType(serviceType);

            return FutureBuilder<Channel>(
                future: Get.find<ChannelController>()
                    .getChannelById(posts[index].channelId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                        onTap: () {
                          Get.to(() => PostDetailView(
                              post: posts[index], channel: snapshot.data));
                        },
                        child: ServicePostCardWidget(
                            servicePost: posts[index], channel: snapshot.data));
                  } else {
                    return SpinKitCircle(
                      color: Get.theme.primaryColor,
                    );
                  }
                });
          }),
    );
  }
}
