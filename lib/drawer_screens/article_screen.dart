import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/drawer_screens/article_info_screen.dart';
import 'package:pets_4_home/models/article_model.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                hintText: 'Search for your articles...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.green.shade900,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    // height: 200.0,

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
                // Stack(
                //   children: [
                //     const ClipRRect(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       child: Image(
                //         image: AssetImage('images/slider_images/dogArt.jpg'),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 30,
                //       left: 20,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           InkWell(
                //             onTap: (){},
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: Colors.green.shade100,
                //               ),
                //               child: const Padding(
                //                 padding: EdgeInsets.symmetric(horizontal: 6.0),
                //                 child: Text('DOGS'),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(width: 5,),
                //           InkWell(
                //             onTap: (){},
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: Colors.green.shade100,
                //               ),
                //               child: const Padding(
                //                 padding: EdgeInsets.symmetric(horizontal: 6.0),
                //                 child: Text('GENERAL'),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(width: 5,),
                //           InkWell(
                //             onTap: (){},
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: Colors.green.shade100,
                //               ),
                //               child: const Padding(
                //                 padding: EdgeInsets.symmetric(horizontal: 6.0),
                //                 child: Text('BREED FACTS'),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: articleModelList.length,
                itemBuilder: (context, index) {
                  final articleList=articleModelList[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return  ArticleInfo(
                          aritcleModelList:articleList,
                        );
                      }));
                    },
                    child: Card(
                      elevation: 0.5,
                      shadowColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image(
                            image: AssetImage(articleList.imageUrl),
                            height: 80,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                          articleList.titleText,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          articleList.subtitleText,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(articleList.trailingText),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ])),
    );
  }
}
