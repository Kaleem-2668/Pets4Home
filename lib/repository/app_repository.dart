import 'dart:convert';

import 'package:pets_4_home/models/category_model.dart';
import 'package:pets_4_home/models/category_wise_model.dart';

import '../models/article_model.dart';
import 'package:http/http.dart'as http;

class AppRepository {
  String baseUrl = 'https://wowpetspalace.com/dashboard';
  Future<List<ArticleModel>> getArticlesApi() async {
    String url = '$baseUrl/article/getarticles';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print('**************************article api response ***************************************');
      print(body.toString());
      List<ArticleModel> articles = body.map((json) => ArticleModel.fromJson(json)).toList();
      return articles;
    }
    throw Exception('error');
  }
  Future<List<CategoryModel>> getCategoryApi() async {
      String url = '$baseUrl/categoryarticle/showcategoryarticle';
    final response = await http.get(Uri.parse(url));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print('****************************category api response*************************************');
      print(body.toString());
      List<CategoryModel> category = body.map((json) => CategoryModel.fromJson(json)).toList();
      return category;
    }
    throw Exception('Error in getCategoryApi: ${response.statusCode}');
  }
  Future<CategoryWiseModel> getCategoryWiseApi(int categoryId) async {
    String url = '$baseUrl/article/getcategorybyid/$categoryId';
    final response = await http.get(Uri.parse(url));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      print('****************************categoryWise api response*************************************');
      print(jsonResponse.toString());
      return CategoryWiseModel.fromJson(jsonResponse);
      } else {
        // Handle the case where the success flag is false
        //print('Error in API response: ${jsonResponse['message']}');
        throw Exception('Error in API response');
      }
    }





}

