import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iarticle_repository.dart';

class ArticlePostController extends GetxController {
  IArticleRepository _articleRepository;
  ArticlePostController(this._articleRepository);
  Future<List<ArticlePost>> getHighestRatedArticles() async {
    return await _articleRepository.getHighestRated();
  }

  Future<List<ArticlePost>> getSavedArticles() async {
    return await _articleRepository.getSavedArticles();
  }
}
