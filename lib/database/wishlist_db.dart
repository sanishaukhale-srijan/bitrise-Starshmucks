import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/model/wishlist_model.dart';

class WishlistDB {
  Future<Database> initWishlistDB() async {
    String dBPath = await getDatabasesPath();
    final path = join(dBPath, "Wishlist.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS WishlistTable(
          id INT NOT NULL UNIQUE
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertWishlistData(WishlistModel item) async {
    final Database db = await initWishlistDB();
    int count = await db.insert("WishlistTable", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (count == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<WishlistModel>> getWishlistData() async {
    final Database db = await initWishlistDB();
    final List<Map<String, dynamic>> data = await db.query("WishlistTable");
    return data.map((e) => WishlistModel.fromJson(e)).toList();
  }

  isInWishlist(id) async {
    final Database db = await initWishlistDB();
    final List<Map<String, dynamic>> data =
        await db.query('WishlistTable', where: 'id = ?', whereArgs: [id]);
    return data.length == 1;
  }

  Future<void> deleteFromWishlist(WishlistModel item) async {
    final db = await initWishlistDB();
    await db.delete('WishlistTable', where: 'id = ?', whereArgs: [item.id]);
  }
}
