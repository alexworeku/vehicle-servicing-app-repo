import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/view/channel_profile_view.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';

class SavedArticlesView extends StatelessWidget {
  final articlePostController = Get.find<ArticlePostController>();
  SavedArticlesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Articles"),
      ),
      body: ListView.builder(
          itemCount: articlePostController.getSavedArticlePosts().length,
          itemBuilder: (ctx, index) {
            var posts = articlePostController.getSavedArticlePosts();
            return Column(
              children: [
                Slidable(
                  actionPane: SlidableScrollActionPane(),
                  secondaryActions: [
                    IconSlideAction(
                      icon: Icons.delete,
                      onTap: () {},
                    ),
                  ],
                  child: ListTile(
                    onTap: () {
                      Get.to(() => PostDetailView(
                            post: posts[index],
                            isSavedArticlePost: true,
                          ));
                    },
                    leading: Image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      image: AssetImage(posts[index].imageUrl),
                    ),
                    title: Text(
                      posts[index].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      posts[index].content,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {},
                    ),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
