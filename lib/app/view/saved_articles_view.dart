import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/custom_list_tile.dart';

class SavedArticlesView extends StatefulWidget {
  SavedArticlesView({Key key}) : super(key: key);

  @override
  _SavedArticlesViewState createState() => _SavedArticlesViewState();
}

class _SavedArticlesViewState extends State<SavedArticlesView> {
  final articlePostController = Get.find<ArticlePostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Articles",
          style: Get.theme.textTheme.headline6,
        ),
      ),
      body: FutureBuilder<List<ArticlePost>>(
          future: articlePostController.getSavedArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
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
                                color: Colors.redAccent,
                                icon: Icons.delete,
                                onTap: () async {
                                  await articlePostController
                                      .removeSavedArticle(
                                          snapshot.data[index].id);
                                  setState(() {});
                                  Get.showSnackbar(
                                    GetBar(
                                      title: "Article Removed",
                                      message: "Article Removed Successfully.",
                                      icon: Icon(Icons.delete),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                            child: InkWell(
                              onTap: () {
                                Get.to(() => PostDetailView(
                                      post: posts[index],
                                      isSavedArticlePost: true,
                                    ));
                              },
                              child: CustomListTile(
                                leading: posts[index].imageUrl != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot.data[index].imageUrl,
                                        placeholder: (ctx, imgProvider) =>
                                            SpinKitCircle(
                                                size: 15,
                                                color: Get.theme.primaryColor),
                                        errorWidget: (ctx, url, error) =>
                                            Icon(Icons.error),
                                        imageBuilder: (ctx, imgProvider) {
                                          return CircleAvatar(
                                            radius: 30,
                                            backgroundImage: imgProvider,
                                          );
                                        },
                                      )
                                    : CircleAvatar(
                                        child: Icon(Icons.car_repair)),
                                title: Text(
                                  posts[index].title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  posts[index].content,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    });
              } else {
                return Center(child: Text("No posts saved yet"));
              }
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
