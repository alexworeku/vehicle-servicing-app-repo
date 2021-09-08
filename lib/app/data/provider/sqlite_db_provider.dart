import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqliteDbProvider {
  static SqliteDbProvider _instance;
  Database _db;
  String _dbPath;
  SqliteDbProvider._();
  static SqliteDbProvider get getInstance {
    if (_instance == null) {
      _instance = SqliteDbProvider._();
    }

    return _instance;
  }

  Database get getDB => _db;
  Future<void> openDB() async {
    String path = await getDatabasesPath();
    _dbPath = join(path, "vsa.db");

    _db = await openDatabase(join(path, "vsa.db"), version: 1, onCreate: (
      db,
      index,
    ) async {
      await db.execute(
          "CREATE TABLE ArticlePost(Id Text PRIMARY KEY,Title Text NOT NULL,Duration INTEGER NOT NULL,Content TEXT NOT NULL, Likes INTEGER NOT NULL,ImageUrl TEXT NOT NULL,Tags Text Not Null,RegisteredDate TEXT NOT NULL,ChannelId TEXT NOT NULL)");
    });
  }

  Future<void> closeDB() async {
    await _db.close();
  }
}
