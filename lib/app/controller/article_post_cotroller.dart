import 'package:vehicleservicingapp/app/data/model/article_post.dart';

class ArticlePostController {
  List<ArticlePost> getAllPosts() {
    return [
      ArticlePost(
          title: "How to fix engine failure to start",
          content:
              "In order to fix an engine problem we have to first check if the battery is plugged in",
          duration: 6,
          likes: 30,
          imageUrl: "assets/images/article1.jpg"),
      ArticlePost(
          title: "How to fix engine failure to start",
          content:
              "In order to fix an engine problem we have to first check if the battery is plugged in",
          duration: 10,
          likes: 120,
          imageUrl: "assets/images/article2.jpg"),
      ArticlePost(
          title: "How to fix engine failure to start",
          content:
              "In order to fix an engine problem we have to first check if the battery is plugged in",
          duration: 4,
          likes: 58,
          imageUrl: "assets/images/article1.jpg"),
    ];
  }
}
