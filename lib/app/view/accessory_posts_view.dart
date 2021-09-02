import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
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
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            itemCount: Get.find<AccessoryPostController>().getPostsCount(),
            itemBuilder: (context, index) {
              AccessoryPost post =
                  Get.find<AccessoryPostController>().getAllPosts()[index];
              return AccessoryPostCardView(
                accessoryPost: post,
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
      ),
    );
  }
}
