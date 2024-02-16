//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:pets_4_home/models/category_wise_model.dart';
// import 'package:pets_4_home/view_model/article_view_model.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../models/article_model.dart';
//
// import '../../../models/category_model.dart';
// import '../user/user_screen.dart';
// import 'article_info_screen.dart';
//
// class ArticleScreen extends StatefulWidget {
//   const ArticleScreen({Key? key}) : super(key: key);
//
//   @override
//   _ArticleScreenState createState() => _ArticleScreenState();
// }
//
// class _ArticleScreenState extends State<ArticleScreen> {
//   final articleViewModel = ArticleViewModel();
//   String baseUrl = 'https://wowpetspalace.com/dashboard';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SafeArea(
//           child: TextFormField(
//             onChanged: (query) {
//               //filterArticles(query);
//             },
//             style: const TextStyle(color: Colors.white, fontSize: 18.0),
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 15,
//                 horizontal: 15,
//               ),
//               hintText: 'Search for your Article',
//               hintStyle: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold),
//               suffixIcon: const Icon(Icons.search, color: Colors.white,),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(color: Colors.white),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white), // Set focused border color
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Stack(
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       enableInfiniteScroll: true,
//                       autoPlay: true,
//                       autoPlayInterval: const Duration(seconds: 4),
//                       autoPlayAnimationDuration:
//                       const Duration(milliseconds: 800),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enlargeCenterPage: true,
//                     ),
//                     items: [
//                       'images/slider_images/dogArt.jpg',
//                       'images/slider_images/slide_a.jpg',
//                       'images/slider_images/slideb.jpg',
//                     ].map((String item) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return ClipRRect(
//                             borderRadius:
//                             const BorderRadius.all(Radius.circular(20)),
//                             child: Image.asset(
//                               item,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20,),
//               FutureBuilder<List<CategoryModel>>(
//                   future: articleViewModel.fetchCategoryData(),
//                   builder: (BuildContext context, snapshot){
//                     if(snapshot.connectionState == ConnectionState.waiting){
//                       return  Center(child: Container());
//                     }else if(snapshot.hasError){
//                       return const Text('error');
//
//                     }else {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Row(
//                           //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: snapshot.data!.map((categoryData) {
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 5.0),
//                               child: GestureDetector(
//                                 child: InkWell(
//                                   onTap: (){
//
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.green.shade700,
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 2),
//                                       child: Text(categoryData.categoryName.toString(),
//                                         style: const TextStyle(fontSize:17,fontWeight: FontWeight.bold,color: Colors.white),),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       );
//
//                     }
//
//                   }),
//                const SizedBox(height: 10),
//               FutureBuilder<List<ArticleModel>>(
//                 future: articleViewModel.fetchArticleData(),
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Shimmer.fromColors(
//                       baseColor: Colors.grey.shade300,
//                       highlightColor: Colors.grey.shade200,
//                       child: _buildShimmerCard(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Text('something went wrong');
//                   } else {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         final articleData = snapshot.data![index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (ctx) {
//                                 return ArticleInfo(
//                                   articleModelList: articleData,
//                                 );
//                               }),
//                             );
//                           },
//                           child: Card(
//                             elevation: 0.5,
//                             shadowColor: Colors.grey.shade200,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 leading: SizedBox(
//                                   height: 80,
//                                   width: 80,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(14),
//                                     child:  CachedNetworkImage(
//                                       imageUrl: "https://wowpetspalace.com/dashboard/${articleData.image}",
//                                       placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                                       errorWidget: (context, url, error) => const Icon(Icons.error),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   articleData.title!,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   articleData.description!,
//                                   maxLines: 2,
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // trailing: Padding(
//                                 //   padding: const EdgeInsets.symmetric(
//                                 //     horizontal: 10.0,
//                                 //   ),
//                                 //   child: Text(articleData.categoryName!),
//                                 // ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmerCard() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Container(
//                 height: 80,
//                 width: 80,
//                 color: Colors.white,
//               ),
//             ),
//             title: Container(
//               height: 15,
//               color: Colors.white,
//             ),
//             subtitle: Container(
//               height: 13,
//               color: Colors.white,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/models/category_wise_model.dart';
import 'package:pets_4_home/view_model/articles/article_view_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/article_model.dart';

import '../../../models/category_model.dart';
import 'article_info_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final articleViewModel = ArticleViewModel();
  String baseUrl = 'https://wowpetspalace.com/dashboard';
  List<ArticleModel> articles = [];
  List<CategoryModel> categories = [];
  List<Data> categoryWiseData = [];
  bool isCategorySelected = false;
  late Future<List<CategoryModel>> categoryDataFuture;
  int? selectedCategoryId;
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchArticleData();
    categoryDataFuture = articleViewModel.fetchCategoryData();
  }
  void filterArticles(String query) {
    if (query.isNotEmpty) {
      List<ArticleModel> filteredArticles = articles
          .where((article) =>
          article.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        articles = filteredArticles;
      });
    } else {
      fetchArticleData();
    }
  }
  void fetchArticleData() async {
    try {
      List<ArticleModel> fetchedArticles =
      await articleViewModel.fetchArticleData();
      setState(() {
        articles = fetchedArticles;
      });
    } catch (e) {
      // Handle error
      print('Error fetching articles: $e');
    }
  }
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final articleData = articles[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) {
                return ArticleInfo(
                  articleModelList: articleData,
                );
              }),
            );
          },
          child: Card(
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
                      "https://wowpetspalace.com/dashboard/${articleData.image}",
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(
                  articleData.title!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  articleData.description!,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
                    "https://wowpetspalace.com/dashboard/${categoryWise.image.toString()}",
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
          onChanged: (query) {
            filterArticles(query);
          },
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
              borderSide: const BorderSide(
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 20,),
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
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: snapshot.data!.map((categoryData) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                // Handle category selection
                                onCategorySelected(categoryData.categoryid ?? 0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: selectedCategoryId == categoryData.categoryid
                                      ? Colors.green.shade700// Set the selected category color
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
              // Display either articles or category-wise data based on the state
              buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
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

