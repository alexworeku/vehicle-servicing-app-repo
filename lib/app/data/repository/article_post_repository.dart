import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iarticle_repository.dart';

class ArticlePostrepository implements IArticleRepository {
  @override
  Future<bool> add(ArticlePost post) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<ArticlePost>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<ArticlePost>> getHighestRated() {
    // TODO: implement getHighestRated
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(String id, ArticlePost newValue) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<ArticlePost>> getSavedArticles() {
    // TODO: implement getSavedArticles
    throw UnimplementedError();
  }
}
