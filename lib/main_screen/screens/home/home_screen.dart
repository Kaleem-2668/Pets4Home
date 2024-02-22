import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/appBar/setting/profile_screen.dart';
import 'package:pets_4_home/main_screen/screens/drawer/article_screen.dart';
import 'package:pets_4_home/main_screen/screens/home/favorite_screen.dart';
import 'package:pets_4_home/models/pets_category_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/shared_post_model.dart';
import '../../../provider/language_provider.dart';
import '../auth/login_screen.dart';
import '../drawer/article_info_screen.dart';
import '../drawer/breed_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_info_screen.dart';

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
  bool enable = true;
  bool _mounted = true;
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();
  late Future<List<SharedPostModel>> _futureSharedPosts;

  @override
  void initState() {
    super.initState();
    _futureSharedPosts = articleViewModel.fetchSharedPostsApi();
  }

  Future<void> _refreshData() async {
    setState(() async {
      _futureSharedPosts = articleViewModel.fetchSharedPostsApi();
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 4));
    if (_mounted) {
      setState(() {
        enable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // DataBaseHelper dbHelper = DataBaseHelper.instance;
    return BackdropScaffold(
      backLayerBackgroundColor: Colors.green.shade100,
      appBar: BackdropAppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
        // backgroundColor: Colors.green.shade800,
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
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const ArticleScreen();
                  // }));
                },
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
                    return const FavoriteScreen();
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
        child: SingleChildScrollView(
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
                                  onTap: () {},
                                  child: const Icon(Icons.search)),
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      child:
                          // enable ? _buildPetsCategoryShimmer() :
                          _buildPetsCategoryList(),
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
                    RefreshIndicator(
                      key: _refreshKey,
                      onRefresh: _refreshData,
                      child: FutureBuilder<List<SharedPostModel>>(
                        future: _futureSharedPosts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildPetsGridShimmer(); // Add shimmer while loading
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return _buildPetsGrid(
                                snapshot.data!); // Pass the data to the grid
                          } else {
                            return const Text('No data available');
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
}

Widget _buildPetsGrid(List<SharedPostModel> sharedPosts) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      childAspectRatio: 0.6,
    ),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: sharedPosts.length,
    itemBuilder: (context, index) {
      SharedPostModel post = sharedPosts[index];

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: Image.network(
                      "https://wowpetspalace.com/dashboard/${post.imagePaths![0]}",
                      // ^ Use the first image path
                      height: 50,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.categoryTitle.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.categoryTitle.toString(),
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
        ),
      );
    },
  );
}

Widget _buildPetsGridShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.builder(
      itemCount: 9,
      // Adjust the count as needed
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
