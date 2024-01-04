import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/article_model.dart';
import 'article_info_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool enable = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      enable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },

        ),
        title: TextFormField(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: articleModelList.length,
                itemBuilder: (context, index) {
                  final articleList = articleModelList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ArticleInfo(
                              articleModelList: articleList,
                            );
                          },
                        ),
                      );
                    },
                    child: enable
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade200,
                            child: _buildShimmerCard(),
                          )
                        : _buildArticleCard(articleList),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Card(
      elevation: 0.5,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 80,
          width: 80,
          color: Colors.white,
        ),
        title: Container(
          height: 15,
          color: Colors.white,
        ),
        subtitle: Container(
          height: 13,
          color: Colors.white,
        ),
        trailing: Container(
          width: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildArticleCard(ArticleModel articleList) {
    return Card(
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          articleList.subtitleText,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(articleList.trailingText),
        ),
      ),
    );
  }
}
