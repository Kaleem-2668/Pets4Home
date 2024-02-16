import 'package:pets_4_home/models/category_model.dart';
import 'package:pets_4_home/models/pets_api_category_model.dart';
import 'package:pets_4_home/repository/app_repository.dart';

import '../../models/article_model.dart';
import '../../models/breed_category_model.dart';
import '../../models/category_wise_model.dart';
import '../../models/register_user_model.dart';

class ArticleViewModel {
  final repo = AppRepository();

  Future<List<ArticleModel>> fetchArticleData() async {
    final response = await repo.getArticlesApi();
    return response;
  }

  Future<List<CategoryModel>> fetchCategoryData() async {
    final response = await repo.getCategoryApi();
    return response;
  }

  Future<CategoryWiseModel> fetchCategoryWiseData(int categoryId) async {
    final response = await repo.getCategoryWiseApi(categoryId);
    return response;
  }
  Future<List<BreedCategoryModel>> fetchBreedCategoryData() async {
    final response = await repo.getBreedCategoryApi();
    return response;
  }
  Future<List<PetsApiCategory>> fetchPetsApiCategory() async {
    final response = await repo.getPetApiCategoryApi();
    return response;
  }
  Future<RegisterModel> registerUser(String username, String password, String email) async {
    final response = await repo.registerUser(username, password, email);
    return response;
  }
}
