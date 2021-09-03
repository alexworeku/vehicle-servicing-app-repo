import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/view/widgets/article_post_card_view.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
          itemCount: Get.find<ArticlePostController>().getPostsCount(),
          itemBuilder: (ctx, index) {
            var posts = Get.find<ArticlePostController>().getAllPosts();
            return ArticlePostCardView(
              post: posts[index],
            );
          }),
    );
  }
}
