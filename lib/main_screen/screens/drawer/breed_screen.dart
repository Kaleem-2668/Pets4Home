
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/models/pets_api_category_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/breed_category_model.dart';
import '../../../view_model/article_view_model.dart';
import 'breed_info_screen.dart';

class BreedScreen extends StatefulWidget {
  const BreedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BreedScreen> createState() => _BreedScreenState();
}

class _BreedScreenState extends State<BreedScreen> {
  final articleViewModel = ArticleViewModel();
  PetsApiCategory? selectedPet;
  Future<List<PetsApiCategory>>? petsApiFuture;
  Future<List<BreedCategoryModel>>? breedCategoryFuture;
  @override
  void initState() {
    super.initState();
    // Initialize the future for the first API call
    petsApiFuture = articleViewModel.fetchPetsApiCategory();
    // Initialize the future for the second API call
    breedCategoryFuture = articleViewModel.fetchBreedCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breed Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
            SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .15,
            child: FutureBuilder(
              future: petsApiFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerUI(); // Display shimmer effect in the exact UI location
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading breed category data'),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    (snapshot.data as List).isEmpty) {
                  return const Center(
                    child: Text('No breed category data available'),
                  );
                } else {
                  // Set petsApiFuture to null to prevent further API calls
                  petsApiFuture = null;
                  List<PetsApiCategory> petsApi =
                  (snapshot.data as List).cast<PetsApiCategory>();

                  if (selectedPet == null && petsApi.isNotEmpty) {
                    selectedPet = petsApi.first;
                  }

                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        imageUrl: selectedPet!.image != null &&
                                            selectedPet!.image!.isNotEmpty
                                            ? "https://wowpetspalace.com/dashboard/${selectedPet!.image}"
                                            : "https://example.com/placeholder_image.jpg",
                                        placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(selectedPet?.title ?? ''),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (query) {
                  // Filter articles based on query
                },
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  hintText: 'Find your breed',
                  hintStyle: const TextStyle(
                      color: Colors.black,),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .55,
                child: FutureBuilder(
                  future: breedCategoryFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoadingState();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading breed category data: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        (snapshot.data as List).isEmpty) {
                      return const Center(
                        child: Text('No breed category data available'),
                      );
                    } else {
                      breedCategoryFuture = null;
                      List<BreedCategoryModel> breedCategoryList =
                      (snapshot.data as List).cast<BreedCategoryModel>();

                      return ListView.builder(
                        itemCount: breedCategoryList.length,
                        itemBuilder: (context, index) {
                          BreedCategoryModel selectedBreed = breedCategoryList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                                imageUrl: selectedBreed.breedImages != null &&
                                    selectedBreed.breedImages!.isNotEmpty
                                    ? "https://wowpetspalace.com/dashboard/${selectedBreed.breedImages![0]}"
                                    : "https://example.com/placeholder_image.jpg",
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
                              // Padding(
                              //   padding: const EdgeInsets.all(16.0),
                              //   child: Text(
                              //     selectedBreed.breedDescription ?? '',
                              //     style: const TextStyle(
                              //       fontSize: 16,
                              //     ),
                              //   ),
                              // ),
                              // Add more widgets as needed
                            ],
                          );
                        },
                      );
                    }
                  },
                ),

              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const BreedInfoScreen(
                          breedId: 1,
                        );
                      },
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green,
                    ),
                    child: const Center(child: Text('Breed Details',style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          height:300 ,
          color: Colors.white,
        ),
        const SizedBox(height: 8),
        Container(
          height: 15,
          width: 150,
          color: Colors.white,
        ),
      ],
    ),
  );
}

Widget _buildShimmerUI() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white, // Use color instead of decoration
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 70,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
