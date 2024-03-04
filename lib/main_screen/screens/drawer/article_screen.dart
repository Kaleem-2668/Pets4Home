import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/models/category_wise_model.dart';
import 'package:pets_4_home/view_model/articles/article_view_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/article_model.dart';

import '../../../models/category_model.dart';

import 'package:http/http.dart' as http;

import 'article_info_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final articleViewModel = ArticleViewModel();
  String baseUrl = 'https://wowpetspalace.com/dashboard';
  List<CategoryModel> categories = [];
  List<Data> categoryWiseData = [];
  bool isCategorySelected = false;
  late Future<List<CategoryModel>> categoryDataFuture;
  int? selectedCategoryId;
  TextEditingController searchController = TextEditingController();
  ArticleModel? articleModel;
  int currentPage = 1;
  bool isLoading = false;
  bool reachedEnd = false; // Track if all pages have been loaded
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    categoryDataFuture = articleViewModel.fetchCategoryData();
    fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    if (isLoading || reachedEnd) return;

    final apiUrl =
        'https://wowpetspalace.com/dashboard/article/getarticles/$currentPage';

    try {
      isLoading = true;
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        ArticleModel newPage = ArticleModel.fromJson(jsonData);

        if (newPage.articles!.isEmpty) {
          // No more data to load
          reachedEnd = true;
        } else {
          if (articleModel == null) {
            articleModel = newPage;
          } else {
            articleModel!.articles!.addAll(newPage.articles!);
            articleModel!.currentPage = newPage.currentPage;
            articleModel!.totalPages = newPage.totalPages;
          }

          currentPage++;
        }

        isLoading = false;
        setState(() {});
      } else {
        print('Error fetching data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  // void filterArticles(String query) {
  //   if (query.isNotEmpty) {
  //     List<ArticleModel> filteredArticles = articles
  //         .where((article) =>
  //         article.articles!.any((articleData) =>
  //             articleData.title!.toLowerCase().contains(query.toLowerCase())))
  //         .toList();
  //
  //     setState(() {
  //       articles = filteredArticles;
  //     });
  //   } else {
  //   }
  // }

  void fetchCategoryData() async {
    try {
      List<CategoryModel> fetchedCategories =
          await articleViewModel.fetchCategoryData();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void onCategorySelected(int categoryId) async {
    try {
      CategoryWiseModel fetchedCategoryWiseData =
          await articleViewModel.fetchCategoryWiseData(categoryId);
      setState(() {
        categoryWiseData = fetchedCategoryWiseData.data ?? [];
        isCategorySelected = true;
        selectedCategoryId = categoryId;
      });
    } catch (e) {
      // Handle error
      print('Error fetching category-wise data: $e');
    }
  }

  void resetToArticlesView() {
    setState(() {
      isCategorySelected = false;
      categoryWiseData.clear();
    });
  }

  // Function to display articles or category-wise data
  Widget buildContent() {
    if (isCategorySelected) {
      return buildCategoryWiseList();
    } else {
      return buildArticleList();
    }
  }

  Widget buildArticleList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: reachedEnd
                ? articleModel?.articles?.length ?? 0
                : (articleModel?.articles?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == (articleModel?.articles?.length ?? 0)) {
                if (!reachedEnd) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox
                      .shrink(); // Placeholder for the last loading indicator
                }
              }

              Articles article = articleModel!.articles![index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) {
                      return ArticleInfo(
                          articleModelList: articleModel, selectedIndex: index);
                    }),
                  );
                },
                child: ListTile(
                  title: Text(article.title ?? ''),
                  subtitle: Text(article.description ?? '', maxLines: 2),
                  leading: Image.network(
                    "https://wowpetspalace.com/dashboard/${article.image?.toString() ?? ''}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategoryWiseList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoryWiseData.length,
      itemBuilder: (context, index) {
        final categoryWise = categoryWiseData[index];
        return Card(
          elevation: 0.5,
          shadowColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://wowpetspalace.com/dashboard/${categoryWise.image![0]}",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(
                categoryWise.title.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                categoryWise.description.toString(),
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            hintText: 'Search for your Article',
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    'images/slider_images/dogArt.jpg',
                    'images/slider_images/slide_a.jpg',
                    'images/slider_images/slideb.jpg',
                  ].map((String item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<CategoryModel>>(
              future: categoryDataFuture,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: _buildShimmerCard(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('error');
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: snapshot.data!.map((categoryData) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              onCategorySelected(categoryData.categoryid ?? 0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: selectedCategoryId ==
                                        categoryData.categoryid
                                    ? Colors.green.shade700
                                    : Colors.green.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 2),
                                child: Text(
                                  categoryData.categoryName.toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 80,
                width: 80,
                color: Colors.white,
              ),
            ),
            title: Container(
              height: 15,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 13,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
