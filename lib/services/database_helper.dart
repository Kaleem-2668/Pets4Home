// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DataBaseHelper{
//   final String dbName = 'Pets4home.db';
//   final String tableName= 'favoritePets';
//   DataBaseHelper._privateConstructor();
//   static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
//   static Database? _database;
//
//   Future<Database> get dataBase async{
//     _database??= await initializeDataBase();
//     return _database!;
//
//
// }
//  Future<Database> initializeDataBase()async{
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, dbName);
//     var petsDataBase= await openDatabase(path, version: 1, onCreate: createDb);
//     return petsDataBase;
//
//  }
//  void createDb (Database db, int newVersion)async{
//     await db.execute('''CREATE TABLE $tableName (
//     id INTEGER PRIMARY KEY,
//     image TEXT,
//     title TEXT,
//     subtitle TEXT,
//     breedTitle TEXT,
//     price TEXT
//
//     )''');
//
//
// }
// }

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String dbName = 'Pets4home.db';
  final String tableName = 'favoritePets';

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDataBase();
    return _database!;
  }

  Future<Database> initializeDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    print("Database path: $path");
    var petsDataBase = await openDatabase(path, version: 1, onCreate: createDb);
    return petsDataBase;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY, 
      image TEXT,
      title TEXT,
      subtitle TEXT,
      breedTitle TEXT,
      price TEXT
    )''');
  }
}
