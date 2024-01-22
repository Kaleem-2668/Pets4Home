import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/breed_category_model.dart';

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
    String path = '${directory.path}/pets4home.db';
    print("Database path: $path");
    var petsDataBase = await openDatabase(path, version: 2, onCreate: createDb);
    return petsDataBase;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      image TEXT,
      title TEXT,
      subtitle TEXT,
      breedText TEXT,
      price TEXT
    )''');
  }

  Future<int> addPets(BreedCategoryModel favorite) async {
    try {
      Database db = await instance.database;
      int result = await db.rawInsert(
          'INSERT INTO $tableName(image, title, subtitle, breedText, price) VALUES(?,?,?,?,?)',
          [favorite.imageUrl, favorite.titleText, favorite.subtitleText, favorite.breedText, favorite.priceText]);
      return result;
    } catch (e) {
      print("Error adding pet to database: $e");
      return -1; // Return a negative value to indicate an error
    }
  }

  Future<int> removePet(int id) async {
    try {
      Database db = await instance.database;
      int result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      return result;
    } catch (e) {
      print("Error removing pet from database: $e");
      return -1; // Return a negative value to indicate an error
    }
  }

  Future<bool> isFavorite(int id) async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
      return result.isNotEmpty;
    } catch (e) {
      print("Error checking if pet is favorite: $e");
      return false;
    }
  }

  Future<List<BreedCategoryModel>> getFavoritePets() async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(tableName);

      List<BreedCategoryModel> favorites = result.map((map) {
        return BreedCategoryModel(
          id: map['id'],
          imageUrl: map['image'],
          titleText: map['title'],
          subtitleText: map['subtitle'],
          breedText: map['breedText'],
          priceText: map['price'],
        );
      }).toList();

      return favorites;
    } catch (e) {
      print("Error getting favorite pets from database: $e");
      return [];
    }
  }

}




