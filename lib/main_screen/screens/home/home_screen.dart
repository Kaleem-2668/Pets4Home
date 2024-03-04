import 'dart:convert';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/appBar/setting/profile_screen.dart';
import 'package:pets_4_home/main_screen/screens/drawer/article_screen.dart';
import 'package:pets_4_home/main_screen/screens/home/favorite_screen.dart';
import 'package:pets_4_home/models/pets_category_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/shared_post_model.dart';
import '../../../provider/language_provider.dart';
import '../../../services/database_helper.dart';
import '../auth/login_screen.dart';
import '../drawer/breed_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_info_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Language {
  english,
  arabic,
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();
  bool enable = false;
  bool isLoading = false;
  bool reachedEnd = false;
  final List<SharedPostModel> _posts = [];
  int _currentPage = 1;
  bool _hasMoreData = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMoreData) {
          _fetchPosts();
        } else {
          // No more data to load
          print('No more data');
        }
      }
    });
  }

  Future<void> _fetchPosts() async {
    if (isLoading || !_hasMoreData) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final apiUrl = Uri.parse(
          'https://wowpetspalace.com/dashboard/advertisment/getadvertisement/$_currentPage');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonList = jsonResponse['data'];

        final List<SharedPostModel> newPosts =
            jsonList.map((json) => SharedPostModel.fromJson(json)).toList();

        if (newPosts.isEmpty) {
          setState(() {
            _hasMoreData = false;
          });
        } else {
          setState(() {
            _posts.addAll(newPosts);
            _currentPage++;
          });
        }
      } else {
        // Handle error
        if (kDebugMode) {
          print('Failed to load posts - Status Code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
      }
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Failed to load posts - Exception: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _resetData() async {
    setState(() {
      _posts.clear();
      _currentPage = 1;
      _hasMoreData = true;
    });

    await _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Building HomeScreen");
    }
    DataBaseHelper dbHelper = DataBaseHelper.instance;
    return BackdropScaffold(
      backLayerBackgroundColor: Colors.green.shade100,
      appBar: BackdropAppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
        leadingWidth: 60,
        actions: <Widget>[
          Consumer<ChangeLanguage>(builder: (context, provider, child) {
            return PopupMenuButton(
              onSelected: (Language item) {
                if (Language.english.name == item.name) {
                  provider.changeLanguage(const Locale('en'));
                } else {
                  provider.changeLanguage(const Locale('ar'));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
                const PopupMenuItem(
                    value: Language.english, child: Text('english')),
                const PopupMenuItem(
                    value: Language.arabic, child: Text('arabic')),
              ],
            );
          }),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return const ProfileScreen();
              }));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return const LoginScreen();
              }));
            },
          ),
        ],
      ),
      backLayer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ArticleScreen();
                  }));
                },
                child: const Center(
                    child: Text(
                  'ARTICLES',
                  style: TextStyle(fontSize: 18),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: const Center(
                    child: Text(
                  'HOME',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: const Center(
                    child: Text(
                  'FEATURED',
                  style: TextStyle(fontSize: 18),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return FavoriteScreen();
                  }));
                },
                child: const Center(
                    child: Text(
                  'FAVORITE',
                  style: TextStyle(fontSize: 18),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return const BreedScreen();
                  }));
                },
                child: const Center(
                    child: Text(
                  'BREED',
                  style: TextStyle(fontSize: 18),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: const Center(
                    child: Text(
                  'DOGS INFO',
                  style: TextStyle(fontSize: 18),
                ))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: const Center(
                    child: Text(
                  'FAVORITE',
                  style: TextStyle(fontSize: 18),
                ))),
          ],
        ),
      ),
      frontLayer: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                AppLocalizations.of(context)!.name,
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                AppLocalizations.of(context)!.text,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          onTap: () {},
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: AppLocalizations.of(context)!.search,
                            suffixIcon: InkWell(
                                onTap: () {}, child: const Icon(Icons.search)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _locationController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hintText:
                                      AppLocalizations.of(context)!.location,
                                  prefixIcon: const Icon(Icons.location_on),
                                  suffixIcon: const Icon(
                                      Icons.location_searching_rounded),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade700,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 90,
              child: enable
                  ? _buildPetsCategoryShimmer()
                  : _buildPetsCategoryList(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recommended for you',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPetsCategoryList() {
    return ListView.builder(
      itemCount: petsCategoryModel.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                      petsCategoryModel[index].imageUrl,
                    ),
                  ),
                ),
              ),
              Text(petsCategoryModel[index].title),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return Expanded(
      child: _posts.isEmpty
          ? _buildPetsGridShimmer() // Show shimmer effect if _posts is empty
          : GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                childAspectRatio: 0.6,
              ),
              scrollDirection: Axis.vertical,
              itemCount: _posts.length + (_hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _posts.length) {
                  final post = _posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return HomeInfo(
                              breedCategoryModel: post,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3.0,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              "https://wowpetspalace.com/dashboard/${post.imagePaths![0]}",
                              width: double.infinity,
                              height: 80, // Set the desired height
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              post.title.toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.description.toString(),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${post.price}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return _hasMoreData
                      ? const CircularProgressIndicator()
                      : const Text('No more data');
                }
              },
            ),
    );
  }
}

Widget _buildPetsCategoryShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 5, // Adjust the count as needed
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 50,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildPetsGridShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.builder(
      itemCount: 9,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 0.3,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 5),
              Container(
                height: 10,
                color: Colors.white,
              ),
              Container(
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Container(
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    ),
  );
}
