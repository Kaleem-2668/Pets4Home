// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:pets_4_home/view_model/article_view_model.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../models/ArticlModel.dart';
//
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
//
//   final articleViewModel = ArticleViewModel();
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
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Stack(
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     enableInfiniteScroll: true,
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 4),
//                     autoPlayAnimationDuration:
//                     const Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enlargeCenterPage: true,
//                   ),
//                   items: [
//                     'images/slider_images/dogArt.jpg',
//                     'images/slider_images/slide_a.jpg',
//                     'images/slider_images/slideb.jpg',
//                   ].map((String item) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return ClipRRect(
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(20)),
//                           child: Image.asset(
//                             item,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ),
//                         );
//                       },
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: FutureBuilder<List<ArticleModel>>(
//                   future: articleViewModel.fetchArticleData(),
//                   builder: (BuildContext context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Shimmer.fromColors(
//                         baseColor: Colors.grey.shade300,
//                         highlightColor: Colors.grey.shade200,
//                         child: _buildShimmerCard(),
//                       );
//                     } else if (snapshot.hasError) {
//                       return const Text('something went wrong');
//                     } else {
//                       return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final articleData = snapshot.data![index];
//                             return InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context, MaterialPageRoute(builder: (ctx) {
//                                   return ArticleInfo(
//                                       articleModelList: articleData
//                                   );
//                                 }));
//                               },
//                               child: Card(
//                                 elevation: 0.5,
//                                 shadowColor: Colors.grey.shade200,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: ListTile(
//                                   contentPadding: EdgeInsets.zero,
//                                   leading: SizedBox(
//                                     height: 80,
//                                     width: 80,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(14),
//                                       child: Image.network(
//                                         "https://wowpetspalace.com/dashboard/${articleData.image}",
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   title: Text(
//                                     articleData.title!,
//                                     style: const TextStyle(fontSize: 14,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   subtitle: Text(
//                                     articleData.description!, maxLines: 2,
//                                     style: const TextStyle(fontSize: 13,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   trailing: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Text(articleData.categoryName!),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           });
//                     }
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmerCard() {
//     return ListView.builder(
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return ListTile(
//           contentPadding: EdgeInsets.zero,
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Container(
//               height: 80,
//               width: 80,
//               color: Colors.white,
//             ),
//           ),
//           title: Container(
//             height: 15,
//             color: Colors.white,
//           ),
//           subtitle: Container(
//             height: 13,
//             color: Colors.white,
//           ),
//           // trailing: Container(
//           //   width: 50,
//           //   color: Colors.white,
//           // ),
//         );
//
//       },
//
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/view_model/article_view_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/ArticlModel.dart';

import 'article_info_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final articleViewModel = ArticleViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: TextFormField(
            onChanged: (query) {
              //filterArticles(query);
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
              suffixIcon: const Icon(Icons.search, color: Colors.white,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: Colors.white), // Set focused border color
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              FutureBuilder<List<ArticleModel>>(
                future: articleViewModel.fetchArticleData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: _buildShimmerCard(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('something went wrong');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final articleData = snapshot.data![index];
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
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: SizedBox(
                                height: 80,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    "https://wowpetspalace.com/dashboard/${articleData.image}",
                                    fit: BoxFit.cover,
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
                              trailing: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Text(articleData.categoryName!),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
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
        return ListTile(
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
        );
      },
    );
  }
}
