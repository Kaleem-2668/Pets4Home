import 'package:pets_4_home/models/category_model.dart';
import 'package:pets_4_home/models/pets_api_category_model.dart';
import 'package:pets_4_home/models/shared_post_model.dart';
import 'package:pets_4_home/repository/app_repository.dart';

import '../../main_screen/screens/drawer/article_info_screen.dart';
import '../../models/article_model.dart';
import '../../models/breed_category_model.dart';
import '../../models/category_wise_model.dart';
import '../../models/user_model.dart';

class ArticleViewModel {

  final repo = AppRepository();

  int currentPage = 1; // Start with the first page
  List<ArticleModel> articlesList = []; // List to store loaded articles

  // Method to fetch initial articles
  Future<List<ArticleModel>> fetchArticleData() async {
    try {
      final response = await repo.getArticleApi(currentPage);
      articlesList = response; // Update the articles list
      return response;
    } catch (e) {
      print('Error fetching article data: $e');
      rethrow;
    }
  }

  // Method to load more articles when the user scrolls
  Future<void> loadMoreArticles() async {
    try {
      currentPage++; // Increment the page for the next request
      final response = await repo.getArticleApi(currentPage);

      // Append the new articles to the existing list
      articlesList.addAll(response);

    } catch (e) {
      print('Error loading more articles: $e');
    }
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


}
