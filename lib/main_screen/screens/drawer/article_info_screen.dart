import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import '../../../models/article_model.dart';
import '../../../view_model/articles/article_view_model.dart';

class ArticleInfo extends StatefulWidget {
  final ArticleModel? articleModelList;
  final int? selectedIndex;

  const ArticleInfo({Key? key, required this.articleModelList,  this.selectedIndex,}) : super(key: key);

  @override
  _ArticleInfoState createState() => _ArticleInfoState();
}
final articleViewModel = ArticleViewModel();
class _ArticleInfoState extends State<ArticleInfo> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                height: height * .42,
                child: SizedBox(
                  width: double.infinity, // Set width to cover full width
                  height: height * .42,
                  child: CachedNetworkImage(
                    imageUrl: "https://wowpetspalace.com/dashboard/${widget.articleModelList!.articles![0].image.toString()}",
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.articleModelList!.articles![0].title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber.shade700,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child:Text(
                          widget.articleModelList!.articles![0].categoryName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  widget.articleModelList!.articles![0].description.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FabCircularMenuPlus(
        fabColor: Colors.green.shade800,
        fabOpenIcon: const Icon(Icons.share, color: Colors.white),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white),
        ringColor: Colors.green.shade700,
        ringDiameter: 200,
        children: [
          IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.facebook, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {})
        ],
      ),
    );
  }
}
