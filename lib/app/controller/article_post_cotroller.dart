import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';

class ArticlePostController extends GetxController {
  List<ArticlePost> posts = [
    ArticlePost(
        title: "How to fix engine failure to start",
        content:
            "In order to fix an engine problem we have to first check if the battery is plugged in",
        duration: 6,
        likes: 30,
        tags: ["engine", "fix", "candela"],
        imageUrl: "assets/images/article1.jpg"),
    ArticlePost(
        title: "How to fix engine failure to start",
        content:
            "In order to fix an engine problem we have to first check if the battery is plugged in",
        duration: 10,
        likes: 120,
        tags: ["engine", "fix", "candela"],
        imageUrl: "assets/images/article2.jpg"),
    ArticlePost(
        title: "How to fix engine failure to start",
        content:
            "In order to fix an engine problem we have to first check if the battery is plugged in",
        duration: 4,
        likes: 58,
        tags: ["engine", "fix", "candela"],
        imageUrl: "assets/images/article1.jpg"),
  ];
  List<ArticlePost> getAllPosts() {
    return posts;
  }

  List<ArticlePost> getSavedArticlePosts() {
    return posts;
  }

  int getPostsCount() {
    return posts.length;
  }
}
