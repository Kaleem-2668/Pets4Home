import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pets_4_home/models/shared_post_model.dart';
import '../../../services/database_helper.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({Key? key, required this.breedCategoryModel})
      : super(key: key);
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
    int? postId = widget.breedCategoryModel?.id;

    if (postId != null) {
      bool isFav = await DataBaseHelper.instance.isFavorite(postId);
      setState(() {
        isFavorite = isFav;
      });
    } else {
      // Handle the case where postId is null, if needed
      if (kDebugMode) {
        print('Post ID is null');
      }
    }
  }

  Future<void> addToFavorites(int postId) async {
    if (kDebugMode) {
      print("Breed Category Model: ${widget.breedCategoryModel}");
    }
    SharedPostModel favorite = SharedPostModel(
      id: widget.breedCategoryModel!.id,
      imagePaths: widget.breedCategoryModel!.imagePaths,
      title: widget.breedCategoryModel!.title,
      description: widget.breedCategoryModel!.description,
      categoryTitle: widget.breedCategoryModel!.categoryTitle,
      price: widget.breedCategoryModel!.price,
    );

    if (kDebugMode) {
      print("Adding to favorites: $favorite");
    } // Debugging statement

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

  void toggleFavorite() async {
    if (widget.breedCategoryModel != null) {
      int postId = widget.breedCategoryModel!.id!;

      if (isFavorite) {
        await removeFromFavorites(postId);
      } else {
        await addToFavorites(postId);
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  Future<void> removeFromFavorites(int postId) async {
    try {
      int result = await DataBaseHelper.instance.removePet(postId);
      if (result > 0) {
        Fluttertoast.showToast(
          msg: 'Removed from favorites',
          backgroundColor: Colors.red.shade700,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Not removed',
          backgroundColor: Colors.red.shade700,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error removing from favorites: $e");
      }
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
              CarouselSlider.builder(
                itemCount: widget.breedCategoryModel!.imagePaths!.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.network(
                    "https://wowpetspalace.com/dashboard/${widget.breedCategoryModel!.imagePaths![index]}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    // Handle page change if needed
                  },
                ),
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
                      widget.breedCategoryModel!.categoryTitle.toString(),
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
                        Text(widget.breedCategoryModel!.city.toString()),
                        Text(
                          '(show map)',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.lock_clock),
                        ),
                        Text(widget.breedCategoryModel!.date.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.breedCategoryModel!.price.toString()}',
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
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.breedCategoryModel!.healthchecked.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.breedCategoryModel!.verified.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                    Row(
                      children: [
                        const Expanded(child: Text('Adv.ID')),
                        Expanded(
                            child:
                                Text(widget.breedCategoryModel!.id.toString())),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Views')),
                        Expanded(
                            child: Text(
                                widget.breedCategoryModel!.views.toString())),
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
                            widget.breedCategoryModel!.address.toString(),
                            style: TextStyle(color: Colors.green.shade800),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Advert Type')),
                        Expanded(
                            child: Text(widget
                                .breedCategoryModel!.advertisementType
                                .toString())),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Breed')),
                        Expanded(
                          child: Text(
                            widget.breedCategoryModel!.title.toString(),
                            style: TextStyle(color: Colors.green.shade800),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('Health checked')),
                        Expanded(
                          child: Text(
                            (widget.breedCategoryModel!.healthchecked == 1)
                                ? 'Yes'
                                : 'No',
                          ),
                        )
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
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.breedCategoryModel!.description.toString()),
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
