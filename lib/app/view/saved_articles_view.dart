import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
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
      body: FutureBuilder<List<ArticlePost>>(
          future: articlePostController.getSavedArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty)
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      var posts = snapshot.data;
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
                    });
            } else {
              return Center(child: Text("No posts yet"));
            }
            return Center(
                child: SpinKitCircle(
              color: Get.theme.primaryColor,
              size: 15,
            ));
          }),
    );
  }
}
