import 'package:vehicleservicingapp/app/data/model/article_post.dart';

abstract class IArticleRepository {
  Future<void> add(ArticlePost post);
  Future<void> remove(String id);
  Future<void> update(String id, ArticlePost newValue);
  Future<void> updateOnly(String id, String field, dynamic newValue);

  Future<List<ArticlePost>> getAll();
  Future<List<ArticlePost>> getHighestRated(int limit);
  Future<List<ArticlePost>> getSavedArticles();
}
