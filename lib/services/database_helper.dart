// import 'dart:async';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/shared_post_model.dart';
//
// class DataBaseHelper {
//   final String dbName = 'Pets4home.db';
//   final String tableName = 'favoritePets';
//
//   DataBaseHelper._privateConstructor();
//
//   static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
//   static Database? _database;
//
//   Future<Database> get database async {
//     _database ??= await initializeDataBase();
//     return _database!;
//   }
//
//   Future<Database> initializeDataBase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = '${directory.path}/Pets4home.db';
//     var petsDataBase = await openDatabase(path, version: 1, onCreate: createDb);
//     return petsDataBase;
//   }
//
//   void createDb(Database db, int newVersion) async {
//     await db.execute('''CREATE TABLE $tableName (
//       id INTEGER PRIMARY KEY,
//       imagePaths TEXT,
//       title TEXT,
//       description TEXT,
//       categoryTitle TEXT,
//       price TEXT
//     )''');
//   }
//
//   Future<int> addPets(SharedPostModel favorite) async {
//     try {
//       Database db = await instance.database;
//       int result = await db.rawInsert(
//           'INSERT INTO $tableName(id, imagePaths, title, description, breedText, price) VALUES(?,?,?,?,?,?)',
//           [favorite.id,favorite.imagePaths, favorite.title, favorite.description, favorite.categoryTitle, favorite.price]);
//       return result;
//     } catch (e) {
//       return -1;
//     }
//   }
//
//
//   Future<int> removePet(int id) async {
//     try {
//       Database db = await instance.database;
//       int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
//       return result;
//     } catch (e) {
//       return -1; // Return a negative value to indicate an error
//     }
//   }
//
//   Future<bool> isFavorite(int id) async {
//     try {
//       Database db = await instance.database;
//       List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
//       return result.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<List<SharedPostModel>> getFavoritePets() async {
//     try {
//       Database db = await instance.database;
//       List<Map<String, dynamic>> result = await db.query(tableName);
//
//       List<SharedPostModel> favorites = result.map((map) {
//         return SharedPostModel(
//           id: map['id'],
//           imagePaths: map['imagePaths'],
//           title: map['title'],
//           description: map['description'],
//           categoryTitle: map['categoryTitle'],
//           price: map['price'],
//         );
//       }).toList();
//
//       return favorites;
//     } catch (e) {
//       return [];
//     }
//   }
//
// }

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/shared_post_model.dart';

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
    String path = '${directory.path}/Pets4home.db';
    var petsDataBase = await openDatabase(path, version: 1, onCreate: createDb);
    return petsDataBase;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY,
    imagePaths BLOB,
    title TEXT,
    description TEXT,
    categoryTitle TEXT,
    price TEXT
  )''');
  }


  Future<int> addPets(SharedPostModel favorite) async {
    try {
      Database db = await instance.database;
      String imagePathString = favorite.imagePaths?.join(",") ?? '';

      int result = await db.rawInsert(
        'INSERT INTO $tableName(id, imagePaths, title, description, categoryTitle, price) VALUES(?,?,?,?,?,?)',
        [
          favorite.id ?? '',
          imagePathString,
          favorite.title ?? '',
          favorite.description ?? '',
          favorite.categoryTitle ?? '',
          favorite.price ?? '',
        ],
      );
      return result;
    } catch (e) {
      print('Error adding to favorites: $e');
      return -1;
    }
  }

  Future<int> removePet(int id) async {
    try {
      Database db = await instance.database;
      int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      return result;
    } catch (e) {
      print('Error removing from favorites: $e');
      return -1;
    }
  }

  Future<bool> isFavorite(int id) async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking if favorite: $e');
      return false;
    }
  }
  Future<List<SharedPostModel>> getFavoritePets() async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(tableName);

      List<SharedPostModel> favorites = result.map((map) {
        return SharedPostModel(
          id: map['id'],
          imagePaths: map['imagePaths'].toString().split(","),
          title: map['title'],
          description: map['description'],
          categoryTitle: map['categoryTitle'],
          price: map['price'],
        );
      }).toList();

      return favorites;
    } catch (e) {
      print('Error getting favorite pets: $e');
      return [];
    }
  }

}

