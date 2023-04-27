import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/model/cart_model.dart';

class CartDB {
  Future<Database> initCartDB() async {
    String dBPath = await getDatabasesPath();
    final path = join(dBPath, "Cart.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS CartTable(
          id INT NOT NULL UNIQUE,
          qty INT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertCartData(CartModel item) async {
    final Database db = await initCartDB();
    int count = await db.insert("CartTable", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (count > 0) {
    } else {
      final List<Map<String, dynamic>> maps =
          await db.query("CartTable", where: 'id = ?', whereArgs: [item.id]);
      var test = CartModel(id: maps[0]['id'], qty: maps[0]['qty']);
      increaseQty(test);
    }
    return true;
  }

  Future<List<CartModel>> getCartData() async {
    final Database db = await initCartDB();
    final List<Map<String, dynamic>> data = await db.query("CartTable");
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  clearCart() async {
    final Database db = await initCartDB();
    db.delete("CartTable");
  }

  Future<void> removeItemFromCart(CartModel cartitem) async {
    final db = await initCartDB();
    await db.delete('CartTable', where: 'id = ?', whereArgs: [cartitem.id]);
  }

  increaseQty(CartModel cartitem) async {
    var fido = CartModel(id: cartitem.id, qty: cartitem.qty + 1);
    updateQty(fido);
  }

  decreaseQty(CartModel cartitem) async {
    var fido = CartModel(id: cartitem.id, qty: cartitem.qty - 1);
    updateQty(fido);
  }

  Future<void> updateQty(CartModel cartitem) async {
    final db = await initCartDB();
    await db.update('CartTable', cartitem.toMap(),
        where: 'id = ?', whereArgs: [cartitem.id]);
  }
}
