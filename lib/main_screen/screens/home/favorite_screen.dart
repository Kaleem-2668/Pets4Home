import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/home/home_info_screen.dart';
import 'package:pets_4_home/models/shared_post_model.dart';
import '../../../services/database_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<SharedPostModel>> favoritePets;

  @override
  void initState() {
    super.initState();
    favoritePets = DataBaseHelper.instance.getFavoritePets();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pets'),
      ),
      body: FutureBuilder<List<SharedPostModel>>(
        future: favoritePets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No favorite pets.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                SharedPostModel favoritePet = snapshot.data![index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return HomeInfo(breedCategoryModel: favoritePet);
                    })).then((result) {
                      if (result != null && result is bool && result) {
                        setState(() {
                          favoritePets = DataBaseHelper.instance.getFavoritePets();
                        });
                      }
                    });

                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        favoritePet.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(favoritePet.breedText),
                    subtitle: Text(favoritePet.priceText),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.green),
                      onPressed: ()  {
                         DataBaseHelper.instance.removePet(favoritePet.id);
                        setState(() {
                          favoritePets = DataBaseHelper.instance.getFavoritePets();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
