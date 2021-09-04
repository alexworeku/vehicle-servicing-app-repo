import 'package:vehicleservicingapp/app/data/model/article_post.dart';

abstract class IArticleRepository {
  Future<bool> add(ArticlePost post);
  Future<bool> remove(String id);
  Future<bool> update(String id, ArticlePost newValue);
  Future<List<ArticlePost>> getAll();
  Future<List<ArticlePost>> getHighestRated();
  Future<List<ArticlePost>> getSavedArticles();
}
