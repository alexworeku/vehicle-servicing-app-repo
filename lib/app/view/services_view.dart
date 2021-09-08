import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/repository/service_post_repository.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/search_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/service_post_card_widget.dart';

class ServicesView extends StatefulWidget {
  final String serviceType;

  ServicesView({Key key, this.serviceType}) : super(key: key);

  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final controller =
      Get.put(new ServicePostController(ServicePostRepository()));

  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceType, style: Get.theme.textTheme.headline6),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchView(
                      isService: true,
                      serviceType: widget.serviceType,
                    ));
              })
        ],
      ),
      body: FutureBuilder<List<ServicePost>>(
          future: controller.getPostsByType(widget.serviceType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return SmartRefresher(
                  controller: refreshController,
                  header: WaterDropMaterialHeader(),
                  enablePullDown: true,
                  onRefresh: () {
                    setState(() {});

                    refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
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
                      }),
                );
              } else {
                return Center(
                  child: Text("No posts yet"),
                );
              }
            } else {
              return Center(
                child: SpinKitCircle(
                  color: Get.theme.primaryColor,
                ),
              );
            }
          }),
    );
  }
}
