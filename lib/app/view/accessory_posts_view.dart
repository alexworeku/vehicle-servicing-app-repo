import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/accessory_post_card_view.dart';

class AccessoryPostsView extends StatelessWidget {
  const AccessoryPostsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accessories"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: FutureBuilder<List<AccessoryPost>>(
            future: Get.find<AccessoryPostController>().getAllPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isNotEmpty) {
                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        AccessoryPost post = snapshot.data[index];
                        return FutureBuilder<Channel>(
                            future: Get.find<ChannelController>()
                                .getChannelById(post.channelId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => PostDetailView(
                                          post: post,
                                          channel: snapshot.data,
                                        ));
                                  },
                                  child: AccessoryPostCardView(
                                    accessoryPost: post,
                                    channel: snapshot.data,
                                  ),
                                );
                              }
                              return SpinKitCircle(
                                size: 15,
                                color: Get.theme.primaryColor,
                              );
                            });
                      });
                } else {
                  return Center(
                    child: Text("No posts yet"),
                  );
                }
              }
              return Center(
                child: SpinKitCircle(
                  color: Get.theme.primaryColor,
                ),
              );
            }),
      ),
    );
  }
}
