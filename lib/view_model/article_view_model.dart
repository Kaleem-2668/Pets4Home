import 'package:pets_4_home/models/category_model.dart';
import 'package:pets_4_home/repository/app_repository.dart';

import '../models/ArticlModel.dart';

class ArticleViewModel{
  final repo = AppRepository();
  Future<List<ArticleModel>> fetchArticleData(){
    final response= repo.getArticlesApi();
    return response;
  }
  Future<List<CategoryModel>> fetchCategoryData(){
    final response = repo.getCategoryApi();
    return  response;
  }
}

