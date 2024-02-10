import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/breed_category_model.dart';
import '../../../view_model/articles/article_view_model.dart';

class BreedInfoScreen extends StatefulWidget {
  final int breedId;

  const BreedInfoScreen({Key? key, required this.breedId}) : super(key: key);

  @override
  State<BreedInfoScreen> createState() => _BreedInfoScreenState();
}

class _BreedInfoScreenState extends State<BreedInfoScreen> {
  final articleViewModel = ArticleViewModel();
  late Future<List<BreedCategoryModel>> breedCategoryFuture;

  @override
  void initState() {
    super.initState();
    breedCategoryFuture = articleViewModel.fetchBreedCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breed Information'),
      ),
      body: FutureBuilder(
        future: breedCategoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          } else if (snapshot.hasError) {
            return _buildErrorState();
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              (snapshot.data as List).isEmpty) {
            return const Center(
              child: Text('No breed category data available'),
            );
          } else {
            List<BreedCategoryModel> breedCategoryList =
            (snapshot.data as List).cast<BreedCategoryModel>();

            BreedCategoryModel? selectedBreed = breedCategoryList.firstWhere(
                  (BreedCategoryModel breed) => breed.breedId == widget.breedId,
              // orElse: () => null,
            );

            if (selectedBreed == null) {
              return const Center(
                child: Text('Breed not found'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height*.40,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: selectedBreed.breedImages?.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return CachedNetworkImage(
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.height*.10,
                            imageUrl: "https://wowpetspalace.com/dashboard/$image",
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }).toList() ?? [],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      selectedBreed.categoryTitle ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      selectedBreed.breedTitle ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    child: Text(
                      selectedBreed.breedDescription ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Add more details as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Container(
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Container(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Text('Error loading breed category data'),
    );
  }
}

