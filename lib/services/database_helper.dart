import 'dart:io';

import 'package:health_bloom/model/profile_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'profile.db';
  static final _dbVersion = 1;
  static final _tableName = 'profileTable';
  static final id = '_id';
  static final userName = 'userName';
  static final userPic = "userPic";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initiateDatabase();
    return _database;
  }

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    var newDb =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    print('*************DATABASE INITIALIZED **************');
    return newDb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName ( 
      $id INTEGER PRIMARY KEY,
      $userName TEXT,
      $userPic TEXT
      )
        ''');
  }

  Future<int> insertItemIntoCart(ProfileModel profileModel) async {
    Database db = await instance.database;
    print('*************INSERTING ITEM **************');
    return await db.insert(_tableName, profileModel.toMap());
  }

  Future<List<ProfileModel>> getAllCartItems() async {
    Database db = await instance.database;
    List<Map> list = await db.query(_tableName);
    List<ProfileModel> profileItems = [];
    for (int i = 0; i < list.length; i++) {
      ProfileModel profileModel = ProfileModel(
        list[i]["userName"],
        list[i]["userPic"],
      );

      profileItems.add(profileModel);
    }
    return profileItems;
  }

  Future<int> updateProfile(ProfileModel profileModel) async {
    Database db = await instance.database;
    return db.update(_tableName, profileModel.toMap(),
        where: "userName = ? and userPic=?",
        whereArgs: <String>[
          profileModel.userName,
          profileModel.userPic,
        ]);
  }

  // Future<int> deleteItem(String variationid, String size, String color) async {
  //   Database db = await instance.database;
  //   return db.delete(_tableName,
  //       where: "varitionId = ? and size = ? and color= ?",
  //       whereArgs: [variationid, size, color]);
  // }

  Future<int> deleteProfile() async {
    Database db = await instance.database;
    return db.delete(_tableName);
  }
}
