import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pets_4_home/models/category_model.dart';
import 'package:pets_4_home/models/category_wise_model.dart';
import 'package:pets_4_home/models/pets_api_category_model.dart';
import 'package:pets_4_home/models/shared_post_model.dart';
import '../models/article_model.dart';
import 'package:http/http.dart'as http;
import '../models/breed_category_model.dart';

class AppRepository {
  String baseUrl = 'https://wowpetspalace.com/dashboard';


  Future<List<ArticleModel>> getArticleApi(int currentPage) async {
    String url = '$baseUrl/article/getarticles/$currentPage';
    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print('Requesting article API: $url');
    }

    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      if (kDebugMode) {
        print('****************************article api response*************************************');
      }
      if (kDebugMode) {
        print(body.toString());
      }
      List<ArticleModel> articles = body.map((json) => ArticleModel.fromJson(json)).toList();
      return articles;
    }

    throw Exception('Error in getArticleApi: ${response.statusCode}');
  }
  Future<List<CategoryModel>> getCategoryApi() async {
      String url = '$baseUrl/categoryarticle/showcategoryarticle';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      if (kDebugMode) {
        print('****************************category api response*************************************');
      }
      if (kDebugMode) {
        print(body.toString());
      }
      List<CategoryModel> category = body.map((json) => CategoryModel.fromJson(json)).toList();
      return category;
    }
    throw Exception('Error in getCategoryApi: ${response.statusCode}');
  }
  Future<CategoryWiseModel> getCategoryWiseApi(int categoryId) async {
    String url = '$baseUrl/article/getcategorybyid/$categoryId';
    final response = await http.get(Uri.parse(url));


    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print('****************************categoryWise api response*************************************');
      }

      return CategoryWiseModel.fromJson(jsonResponse);
      } else {
        throw Exception('Error in API response');
      }
    }
  Future<List<BreedCategoryModel>> getBreedCategoryApi() async {
    String url = '$baseUrl/breed/showallbreed';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      if (kDebugMode) {
        print('****************************breedCategory api response*************************************');
      }
      if (kDebugMode) {
        print(body.toString());
      }
      List<BreedCategoryModel> breed = body.map((json) => BreedCategoryModel.fromJson(json)).toList();
      return breed;
    }
    throw Exception('Error in getCategoryApi: ${response.statusCode}');
  }
  Future<List<PetsApiCategory>> getPetApiCategoryApi() async {
    String url = '$baseUrl/breed/getbreed';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      if (kDebugMode) {
        print('**************************PetsCategoryApi api response ***************************************');
      }
      if (kDebugMode) {
        print(body.toString());
      }
      List<PetsApiCategory> petsApi = body.map((json) => PetsApiCategory.fromJson(json)).toList();
      return petsApi;
    }
    throw Exception('error');
  }



}

