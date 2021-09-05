import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/repository/service_post_repository.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ServicesView extends StatelessWidget {
  final String serviceType;
  final controller =
      Get.put(new ServicePostController(ServicePostRepository()));

  ServicesView({Key key, this.serviceType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType, style: Get.theme.textTheme.headline6),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: FutureBuilder<List<ServicePost>>(
          future: controller.getPostsByType(serviceType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      var posts = snapshot.data;

                      return FutureBuilder<Channel>(
                          future: Get.find<ChannelController>()
                              .getChannelById(posts[index].channelId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return InkWell(
                                  onTap: () {
                                    Get.to(() => PostDetailView(
                                        post: posts[index],
                                        channel: snapshot.data));
                                  },
                                  child: ServicePostCardWidget(
                                      servicePost: posts[index],
                                      channel: snapshot.data));
                            }

                            return SpinKitCircle(
                              color: Get.theme.primaryColor,
                            );
                          });
                    });
              } else {
                return Center(
                  child: Text("No posts yet"),
                );
              }
            } else {
              return Center(
                child: SpinKitCircle(
                  color: Get.theme.primaryColor,
                  size: 15,
                ),
              );
            }
          }),
    );
  }
}
