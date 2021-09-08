import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';
import 'package:vehicleservicingapp/app/view/search_view.dart';
import 'package:vehicleservicingapp/app/view/widgets/article_post_card_view.dart';

class ArticlesView extends StatefulWidget {
  const ArticlesView({Key key}) : super(key: key);

  @override
  _ArticlesViewState createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  var refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchView(
                      isArticle: true,
                    ));
              }),
        ],
      ),
      body: FutureBuilder<List<ArticlePost>>(
          future: Get.find<ArticlePostController>().getHighestRatedArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                var posts = snapshot.data;
                return SmartRefresher(
                  controller: refreshController,
                  header: WaterDropMaterialHeader(),
                  enablePullDown: true,
                  onRefresh: () {
                    setState(() {});

                    refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) {
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
                                    child: ArticlePostCardView(
                                        post: posts[index],
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
            }
            return Center(
              child: SpinKitCircle(
                color: Get.theme.primaryColor,
              ),
            );
          }),
    );
  }
}
