import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/article_model.dart';
import 'article_info_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool enable = true;
  List<ArticleModel> filteredArticles = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      enable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: TextFormField(
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
              hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              suffixIcon: const Icon(Icons.search,color: Colors.white,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white), // Set focused border color
              ),
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
              child: enable
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: _buildShimmerCard(),
                    )
                  : _buildArticleList(),
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

  Widget _buildArticleList() {
    return filteredArticles.isNotEmpty
        ? ListView.builder(
            itemCount: filteredArticles.length,
            itemBuilder: (context, index) {
              final articleList = filteredArticles[index];
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
                child: _buildArticleCard(articleList),
              );
            },
          )
        : ListView.builder(
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
                child: _buildArticleCard(articleList),
              );
            },
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

  void filterArticles(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredArticles = [];
      } else {
        filteredArticles = articleModelList
            .where((article) =>
                article.titleText.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
