import 'package:vehicleservicingapp/app/data/model/article_post.dart';

abstract class IArticleRepository {
  bool add(ArticlePost post);
  bool remove(String id);
  bool update(String id, ArticlePost newValue);
  List<ArticlePost> getAll();
  List<ArticlePost> getHighestRated();
}
