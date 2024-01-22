import 'package:flutter/material.dart';
import 'package:pets_4_home/models/breed_category_model.dart';
import '../../../services/database_helper.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<BreedCategoryModel>> favoritePets;

  @override
  void initState() {
    super.initState();
    favoritePets = DataBaseHelper.instance.getFavoritePets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pets'),
      ),
      body: FutureBuilder<List<BreedCategoryModel>>(
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
                BreedCategoryModel favoritePet = snapshot.data![index];
                return ListTile(
                  leading: Image.asset(favoritePet.imageUrl,width: 70,height: 70,fit: BoxFit.cover,),
                  title: Text(favoritePet.breedText),
                  subtitle: Text(favoritePet.priceText),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.green),
                    onPressed: () async {
                      // Remove the item from favorites and refresh the list
                      await DataBaseHelper.instance.removePet(favoritePet.id!);
                      setState(() {
                        favoritePets = DataBaseHelper.instance.getFavoritePets();
                      });
                    },
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
