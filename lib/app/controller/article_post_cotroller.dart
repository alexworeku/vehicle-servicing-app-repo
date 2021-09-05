import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iarticle_repository.dart';

class ArticlePostController extends GetxController {
  IArticleRepository _articleRepository;
  ArticlePostController(this._articleRepository);

  void addArticlePost(ArticlePost post) async {
    await _articleRepository.add(post);
  }

  void updateAccessoryPost(String id, String field, dynamic newValue) async {
    await _articleRepository.updateOnly(id, field, newValue);
  }

  void removeArticlePost(String postId) async {
    await _articleRepository.remove(postId);
  }

  Future<List<ArticlePost>> getHighestRatedArticles() async {
    return await _articleRepository.getHighestRated(10);
  }

  Future<List<ArticlePost>> getAllArticles() async {
    return await _articleRepository.getAll();
  }

  Future<List<ArticlePost>> getSavedArticles() async {
    return await _articleRepository.getSavedArticles();
  }
}
