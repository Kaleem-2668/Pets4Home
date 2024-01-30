import 'dart:convert';

import 'package:pets_4_home/models/category_model.dart';

import '../models/ArticlModel.dart';
import 'package:http/http.dart'as http;

class AppRepository {
  String baseUrl = 'https://wowpetspalace.com/dashboard/article/';
  Future<List<ArticleModel>> getArticlesApi() async {
    String url = '${baseUrl}getarticles';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print('*****************************************************************');
      print(body.toString());
      List<ArticleModel> articles = body.map((json) => ArticleModel.fromJson(json)).toList();
      return articles;
    }
    throw Exception('error');
  }
  Future<List<CategoryModel>> getCategoryApi() async {
     // String url = '${baseUrl}showcategoryarticle';
    String url = 'https://wowpetspalace.com/dashboard/categoryarticle/showcategoryarticle';
    final response = await http.get(Uri.parse(url));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print('*****************************************************************');
      print(body.toString());
      List<CategoryModel> category = body.map((json) => CategoryModel.fromJson(json)).toList();
      return category;
    }
    throw Exception('Error in getCategoryApi: ${response.statusCode}');
  }


}
