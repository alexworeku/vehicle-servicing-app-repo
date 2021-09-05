import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/iarticle_repository.dart';

class ArticlePostrepository implements IArticleRepository {
  @override
  Future<void> add(ArticlePost post) async {
    await FirebaseFirestore.instance.collection("Articles").add(post.toMap());
  }

  @override
  Future<List<ArticlePost>> getAll() async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Articles")
        .orderBy("Date", descending: true)
        .get();
    var posts = <ArticlePost>[];
    snapShot.docs.forEach((doc) {
      posts.add(ArticlePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<List<ArticlePost>> getHighestRated(int limit) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Articles")
        .orderBy("Likes", descending: true)
        .limitToLast(limit)
        .get();
    var posts = <ArticlePost>[];
    snapShot.docs.forEach((doc) {
      posts.add(ArticlePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> remove(String id) async {
    await FirebaseFirestore.instance.collection('Articles').doc(id).delete();
  }

  @override
  Future<void> update(String id, ArticlePost newValue) async {
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(id)
        .set(newValue.toMap());
  }

  @override
  Future<List<ArticlePost>> getSavedArticles() {
    // TODO: implement getSavedArticles
    throw UnimplementedError();
  }

  @override
  Future<void> updateOnly(String id, String field, newValue) async {
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(id)
        .update({field: newValue});
  }
}
