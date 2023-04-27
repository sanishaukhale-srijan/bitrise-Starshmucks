import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/order_history.dart';

class OrdersDB {
  Future<Database> initOrdersDB() async {
    String dBPath = await getDatabasesPath();
    final path = join(dBPath, "Orders.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS OrdersTable(
           orderid INTEGER PRIMARY KEY AUTOINCREMENT,
           id TEXT NOT NULL,
           qty TEXT NOT NULL,
           date TEXT NOT NULL,
           time TEXT NOT NULL)
          """);
      },
      version: 1,
    );
  }

  createArray(idArray, qtyArray, date, time) async {
    var order =
        OrderHistoryModel(id: idArray, qty: qtyArray, date: date, time: time);
    insertOrdersData(order);
  }

  Future<bool> insertOrdersData(OrderHistoryModel order) async {
    final Database db = await initOrdersDB();
    db.insert("OrdersTable", order.toMap());
    return true;
  }

  Future<List<OrderHistoryModel>> getOrdersData() async {
    final Database db = await initOrdersDB();
    final List<Map<String, dynamic>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<List<OrderHistoryModel>> getOrdersDataOnID(id) async {
    final Database db = await initOrdersDB();
    final List<Map<String, dynamic>> data =
        await db.query("OrdersTable", where: 'orderid = ?', whereArgs: [id]);
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<dynamic> getAllData() async {
    final Database db = await initOrdersDB();
    final List<Map<String, dynamic>> data =
        await db.rawQuery("Select * from OrdersTable");
    return data.asMap();
  }
}
