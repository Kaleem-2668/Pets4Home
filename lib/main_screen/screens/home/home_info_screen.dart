import 'package:flutter/material.dart';
import 'package:pets_4_home/models/breed_category_model.dart';

class HomeInfo extends StatefulWidget {
  HomeInfo({Key? key, required this.breedCategoryModel}) : super(key: key);
  BreedCategoryModel? breedCategoryModel;

  @override
  _HomeInfoState createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image:
                AssetImage(widget.breedCategoryModel!.imageUrl.toString()),
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
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {}, child: const Icon(Icons.location_on)),
                        const Text('London'),
                        const Text(
                          '(show map)',
                          style: TextStyle(color: Colors.green),
                        ),
                        InkWell(
                            onTap: () {}, child: const Icon(Icons.lock_clock)),
                        const Text('2 minutes'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.breedCategoryModel!.priceText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
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
                                  child: Icon(Icons.share)),
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
                              child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.favorite_border)),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.amber,
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
                              color: Colors.green.shade800,
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
                              color: Colors.green.shade800,
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
                      style: TextStyle(color: Colors.green.shade800),
                    )),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
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
                        )),
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
                            child: Text('Microchipped by collection\ndate')),
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
                    const Text('Description',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    const Text('This is the description of for Pets which has been selected by user, Every user will find the overall detail of pets here!'
                        'This is the description of for Pets which has been selected by user, Every user will find the overall detail of pets here!'),

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
