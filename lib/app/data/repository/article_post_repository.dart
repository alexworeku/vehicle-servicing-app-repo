import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/provider/sqlite_db_provider.dart';
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

  Future<List<ArticlePost>> getOwnedPosts(String channelId) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Articles")
        .where("ChannelId", isEqualTo: channelId)
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
  Future<List<ArticlePost>> getSavedArticles() async {
    await SqliteDbProvider.getInstance.openDB();

    var result = await SqliteDbProvider.getInstance.getDB
        .rawQuery("Select * from ArticlePost");
    var articlePosts = <ArticlePost>[];
    result.forEach((post) {
      articlePosts
          .add(ArticlePost.fromMap(post['Id'], post, isForOffline: true));
    });
    await SqliteDbProvider.getInstance.closeDB();
    return articlePosts;
  }

  @override
  Future<void> updateOnly(String id, String field, newValue) async {
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(id)
        .update({field: newValue});
  }

  @override
  Future<List<ArticlePost>> getAllByTag(String tag) async {
    var result = await FirebaseFirestore.instance
        .collection("Articles")
        .where("Tags", arrayContains: tag)
        .get();
    var posts = <ArticlePost>[];
    result.docs.forEach((doc) {
      posts.add(ArticlePost.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<bool> removeSaved(String id) async {
    await SqliteDbProvider.getInstance.openDB();
    var result = await SqliteDbProvider.getInstance.getDB
        .rawDelete("Delete From ArticlePost WHERE Id=?", [id]);

    await SqliteDbProvider.getInstance.closeDB();
    return result != 0;
  }

  @override
  Future<bool> saveOffline(ArticlePost post) async {
    await SqliteDbProvider.getInstance.openDB();
    var result = await SqliteDbProvider.getInstance.getDB
        .insert("ArticlePost", post.toMap(isForOffline: true));

    await SqliteDbProvider.getInstance.closeDB();
    return result != 0;
  }
}
