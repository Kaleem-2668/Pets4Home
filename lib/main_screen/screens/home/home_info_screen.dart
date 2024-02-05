import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pets_4_home/models/shared_post_model.dart';
import '../../../services/database_helper.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({Key? key, required this.breedCategoryModel}) : super(key: key);
  final SharedPostModel? breedCategoryModel;

  @override
  _HomeInfoState createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.breedCategoryModel != null) {
      checkIfFavorite();

    }
  }

  void checkIfFavorite() async {
    if (widget.breedCategoryModel != null) {
      bool isFav = await DataBaseHelper.instance.isFavorite(widget.breedCategoryModel!.id);
      setState(() {
        isFavorite = isFav;
      });
    }
  }
  void toggleFavorite() async {
    if (mounted) {
      if (isFavorite) {
        setState(() {
          removeFromFavorites();
        });
      } else {
        addToFavorites();
      }
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }


  void addToFavorites() async {
    SharedPostModel favorite = SharedPostModel(
      id: widget.breedCategoryModel!.id,
      imageUrl: widget.breedCategoryModel!.imageUrl.toString(),
      titleText: widget.breedCategoryModel!.titleText,
      subtitleText: widget.breedCategoryModel!.subtitleText,
      breedText: widget.breedCategoryModel!.breedText,
      priceText: widget.breedCategoryModel!.priceText,
    );

    int result = await DataBaseHelper.instance.addPets(favorite);
    if (result > 0) {
      Fluttertoast.showToast(
        msg: 'Added as favorite',
        backgroundColor: Colors.green.shade800,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Not saved',
        backgroundColor: Colors.red.shade700,
      );
    }
  }

  void removeFromFavorites() async {
    int result = await DataBaseHelper.instance.removePet(widget.breedCategoryModel!.id);
    if (result > 0) {
      Fluttertoast.showToast(
        msg: 'Removed from favorites',
        backgroundColor: Colors.red.shade700,
      );

      // Navigator.pop(context, true);
    } else {
      Fluttertoast.showToast(
        msg: 'Not removed',
        backgroundColor: Colors.red.shade700,
      );
      // Inform the FavoriteScreen that the removal was not successful

    }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage(widget.breedCategoryModel!.imageUrl.toString()),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.breedCategoryModel!.breedText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.location_on),
                        ),
                        const Text('London'),
                        Text(
                          '(show map)',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.lock_clock),
                        ),
                        const Text('2 minutes'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.breedCategoryModel!.priceText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.share),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    toggleFavorite();
                                  },
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red.shade700
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.offline_bolt_sharp),
                          Text("BOOSTED"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 190,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_call,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Call",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 190,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Message",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Get the Pets4Homes Guarantee when you\nmake a Pet Payment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Health protection',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Safe payment',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ID verified breeders',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Learn more about Pet payment',
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Adv.ID')),
                        Expanded(child: Text('HF0T7jnGk')),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Views')),
                        Expanded(child: Text('753')),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Favourites')),
                        Expanded(child: Text('14')),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Adv.Location')),
                        Expanded(
                          child: Text(
                            'Winchmore Hill, London',
                            style: TextStyle(color: Colors.green.shade800),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Advert Type')),
                        Expanded(child: Text('For sale')),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Breed')),
                        Expanded(
                          child: Text(
                            'British shorthair',
                            style: TextStyle(color: Colors.green.shade800),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Health checked')),
                        Expanded(child: Text('yes')),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Text('Microchipped by collection\ndate'),
                        ),
                        Expanded(child: Text('no')),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(child: Text('Neutered')),
                        Expanded(child: Text('no')),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'This is the description of for Pets which has been selected by user, Every user will find the overall detail of pets here!'
                          'This is the description of for Pets which has been selected by user, Every user will find the overall detail of pets here!',
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
}
