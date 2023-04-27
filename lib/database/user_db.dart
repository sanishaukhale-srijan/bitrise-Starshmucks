import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/model/address_model.dart';
import '/model/user_model.dart';

class UserDB {
  //user Data
  Future<Database> initUserDB() async {
    String dBPath = await getDatabasesPath();
    final path = join(dBPath, "User.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserData(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          dob TEXT NOT NULL,
          password TEXT NOT NULL,
          tnc TEXT NOT NULL,
          rewards DOUBLE NOT NULL,
          image TEXT NOT NULL,
          tier TEXT NOT NULL,
          FOREIGN KEY (id) REFERENCES UserAddress(userID)
       )
          """);
//address table
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserAddress(
          addressID INTEGER PRIMARY KEY AUTOINCREMENT,
          userID INTEGER NOT NULL,
          fname TEXT NOT NULL,
          phone TEXT NOT NULL,
          hno TEXT NOT NULL,
          road TEXT NOT NULL,
          city TEXT NOT NULL,
          state TEXT NOT NULL,
          pincode TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertUserData(UserModel user) async {
    final Database db = await initUserDB();
    db.insert("UserData", user.toMap());
    return true;
  }

  Future<List<Map<String, dynamic>>> getUserData() async {
    final Database db = await initUserDB();
    final List<Map<String, dynamic>> data = await db.query("UserData");
    return data;
  }

  Future<void> updateUser(id, um) async {
    final db = await initUserDB();
    await db.update("UserData", um.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> insertUserAddress(AddressModel address) async {
    final Database db = await initUserDB();
    db.insert("UserAddress", address.toMap());
    return true;
  }

  Future<List<AddressModel>> getUserAddressList() async {
    final Database db = await initUserDB();
    final List<Map<String, dynamic>> data = await db.query("UserAddress");
    return data.map((e) => AddressModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getDataUserAddressListOfMap() async {
    final Database db = await initUserDB();
    final List<Map<String, dynamic>> data = await db.query("UserAddress");
    return data;
  }

  Future<void> deleteAddress(id) async {
    final db = await initUserDB();
    await db.delete("UserAddress", where: 'addressID = ?', whereArgs: [id]);
  }

  Future<void> updateAddress(id, am) async {
    final db = await initUserDB();
    await db.update("UserAddress", am.toMap(),
        where: 'addressID = ?', whereArgs: [id]);
  }

  Future<void> updateRewards(am) async {
    final db = await initUserDB();
    await db.update("UserData", am.toMap(), where: 'id= ?', whereArgs: [1]);
  }
}
