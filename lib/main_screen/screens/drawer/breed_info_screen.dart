import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/breed_category_model.dart';
import '../../../view_model/article_view_model.dart';

class BreedInfoScreen extends StatefulWidget {
  final int breedId;

  const BreedInfoScreen({Key? key, required this.breedId}) : super(key: key);

  @override
  State<BreedInfoScreen> createState() => _BreedInfoScreenState();
}

class _BreedInfoScreenState extends State<BreedInfoScreen> {
  final articleViewModel = ArticleViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breed Information'),
      ),
      body: FutureBuilder(
        future: articleViewModel.fetchBreedCategoryData(),
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

            BreedCategoryModel? selectedBreed;
            for (var breed in breedCategoryList) {
              if (breed.breedId == widget.breedId) {
                selectedBreed = breed;
                break;
              }
            }

            if (selectedBreed == null) {
              return const Center(
                child: Text('Breed not found'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: selectedBreed.breedImages != null &&
                            selectedBreed.breedImages!.isNotEmpty
                        ? "https://wowpetspalace.com/dashboard/${selectedBreed.breedImages![0]}"
                        : "https://example.com/placeholder_image.jpg",
                    // Provide a placeholder URL or a local asset path
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      selectedBreed.breedTitle ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
            height:400 ,
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


