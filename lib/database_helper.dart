import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:async';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myCart';
  static final columnID = '_id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initiateDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
    $columnID INTEGER PRIMARY KEY ,
    $columnName TEXT NOT NULL ,
    $columnPrice INTEGER NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    await db.update(_tableName, row, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnID = ?', whereArgs: [id]);
  }

  Future getTotal() async {
    Database db = await instance.database;
    var dbClient = db;
    var result = await dbClient.rawQuery("SELECT SUM(price) FROM myCart");
    int value = result[0]["SUM(price)"];
    return result.toString();
  }
}
