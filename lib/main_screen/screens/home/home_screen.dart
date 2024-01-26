import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/drawer/article_screen.dart';
import 'package:pets_4_home/main_screen/screens/home/favorite_screen.dart';
import 'package:pets_4_home/models/breed_category_model.dart';
import 'package:pets_4_home/models/pets_category_model.dart';
import 'package:pets_4_home/services/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controller/change_language.dart';
import '../auth/login_screen.dart';
import 'home_info_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Language {
  english,
  arabic,
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<BreedCategoryModel>> favoritePets;
  final TextEditingController _locationController = TextEditingController();
  bool enable = true;
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    favoritePets = DataBaseHelper.instance.getFavoritePets();
    loadData();
  }
  @override
  void dispose() {
    _mounted = false; // Set the flag to false when the widget is disposed
    super.dispose();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 4));

    // Check if the widget is still mounted before calling setState
    if (_mounted) {
      setState(() {
        enable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DataBaseHelper dbHelper=DataBaseHelper.instance;
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
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
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
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ArticleScreen();
                  }));
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
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
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
                onTap: () {},
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
                    child: Column(
                      children: [
                        TextFormField(
                          onTap: () {
                            showSearch(context: context, delegate: Search());
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: AppLocalizations.of(context)!.search,
                            suffixIcon: InkWell(
                                onTap: () => showSearch(
                                    context: context, delegate: Search()),
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
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hintText: AppLocalizations.of(context)!.location,
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
                      child: FutureBuilder(
                        future: loadData(),
                        builder: (context, snapshot) {
                          return enable
                              ? _buildPetsCategoryShimmer()
                              : _buildPetsCategoryList();
                        },
                      ),
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
                    FutureBuilder(
                      future: loadData(),
                      builder: (context, snapshot) {
                        return enable
                            ? _buildBreedListShimmer()
                            : _buildBreedCategoryList();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildBreedListShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: breedCategoryModel.length,
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

  Widget _buildBreedCategoryList() {
    return GridView.builder(
      itemCount: breedCategoryModel.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        final breedList = breedCategoryModel[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return HomeInfo(
                    breedCategoryModel: breedList,
                  );
                },
              ),
            );
          },
          child: Card(
            elevation: 0.3,
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
                  child: SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        breedCategoryModel[index].imageUrl,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    breedCategoryModel[index].titleText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    breedCategoryModel[index].subtitleText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(breedCategoryModel[index].breedText),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    breedCategoryModel[index].priceText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Search extends SearchDelegate {
  List<BreedCategoryModel> data = breedCategoryModel;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<BreedCategoryModel> searchResults = data
        .where((breed) =>
            breed.titleText.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isNotEmpty && searchResults.isNotEmpty) {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  breedCategoryModel[index].imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                )),
            title: Text(searchResults[index].titleText),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => HomeInfo(
                    breedCategoryModel: searchResults[index],
                  ),
                ),
              );
            },
            trailing: Text(searchResults[index].priceText),
          );
        },
      );
    } else if (query.isEmpty) {
      return const Text('');
    } else {
      return const ListTile(
        title: Text('No data found'),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BreedCategoryModel> filteredSuggestions = data
        .where((breed) =>
            breed.titleText.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              filteredSuggestions[index].imageUrl,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(filteredSuggestions[index].titleText),
          onTap: () {
            query = filteredSuggestions[index].titleText;
            showResults(context);
          },
          trailing: Text(filteredSuggestions[index].priceText),
        );
      },
    );
  }
}
