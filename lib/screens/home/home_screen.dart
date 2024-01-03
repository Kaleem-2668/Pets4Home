import 'package:flutter/material.dart';
import 'package:pets_4_home/models/breed_category_model.dart';
import 'package:pets_4_home/models/pets_category_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../drawer_screens/article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();
  bool enable = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      enable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implement notifications functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Implement settings functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Implement user profile functionality
            },
          ),
        ],
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to the home screen or perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('Article'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return const ArticleScreen();
                }));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'A safe start to a lifelong\nfriendship',
                style: TextStyle(
                  color: Colors.white,
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
                'Connect with trusted breeders and rescues',
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
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          hintText: 'What are you looking for?',
                          prefixIcon: const Icon(Icons.search),
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
                                hintText: 'Select location',
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
                          // Adjust the spacing between the TextFormField and the ElevatedButton
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade900,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: petsCategoryModel.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (enable) {
                                return Shimmer.fromColors(
                                  highlightColor: Colors.grey.shade100,
                                  baseColor: Colors.grey.shade300,
                                  enabled: true,
                                  child: Container(
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
                                        //fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    // child: SvgPicture.asset(petsCategoryModel[index].imageUrl),
                                  ),
                                );
                              } else {
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
                                            //fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        // child: SvgPicture.asset(petsCategoryModel[index].imageUrl),
                                      ),
                                      Text(petsCategoryModel[index].title),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
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
                  GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6 / 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      breedCategoryModel.length,
                          (index) => enable
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
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
                              const SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(
                                  breedCategoryModel[index].titleText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(
                                  breedCategoryModel[index].subtitleText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(breedCategoryModel[index].breedText),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
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
                      )
                          : Card(
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
                            const SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Text(
                                breedCategoryModel[index].titleText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Text(
                                breedCategoryModel[index].subtitleText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Text(breedCategoryModel[index].breedText),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
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
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:pets_4_home/models/breed_category_model.dart';
// import 'package:pets_4_home/models/pets_category_model.dart';
// import 'package:svg_flutter/svg.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _locationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade900,
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {
//               // Implement notifications functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Implement settings functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               // Implement user profile functionality
//             },
//           ),
//         ],
//         title: const Text('Home Screen'),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 // Navigate to the home screen or perform an action
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 // Navigate to the settings screen or perform an action
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.0),
//             child: Text(
//               'A safe start to a lifelong\nfriendship',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 19,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Text(
//               'connect with trusted breeder and rescues',
//               style: TextStyle(
//                   color: Colors.green.shade700, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.17,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 color: Colors.white,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(vertical: 15),
//                         hintText: 'What are you looking for?',
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _locationController,
//                             decoration: InputDecoration(
//                               contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 15),
//                               hintText: 'Select location',
//                               prefixIcon: const Icon(Icons.location_on),
//                               suffixIcon:
//                                   const Icon(Icons.location_searching_rounded),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         // Adjust the spacing between the TextFormField and the ElevatedButton
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade900,
//                           ),
//                           onPressed: () {},
//                           child: const Text(
//                             'Search',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 90,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                 itemCount: petsCategoryModel.length,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           height: 50,
//                                           width: 50,
//                                           decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: Colors.white),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Image(
//                                               image: AssetImage(
//                                                   petsCategoryModel[index]
//                                                       .imageUrl),
//                                               fit: BoxFit.scaleDown,
//                                             ),
//                                           ),
//                                           // child: SvgPicture.asset(petsCategoryModel[index].imageUrl),
//                                         ),
//                                         Text(petsCategoryModel[index].title),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Recommended for you',
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         child: GridView.count(
//                           crossAxisCount: 3,
//                           childAspectRatio: 0.6 / 1,
//                           scrollDirection: Axis.vertical,
//                           children: List.generate(
//                               breedCategoryModel.length,
//                               (index) => Card(
//                                     elevation: 0.3,
//                                     shadowColor: Colors.grey,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(16),
//                                               topRight: Radius.circular(16)),
//                                           child: SizedBox(
//                                             width: double.infinity,
//                                             height: 90,
//                                             child: Image(
//                                               fit: BoxFit.cover,
//                                               image: AssetImage(
//                                                   breedCategoryModel[index]
//                                                       .imageUrl),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 2,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 6.0),
//                                           child: Text(
//                                               breedCategoryModel[index]
//                                                   .titleText,
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 12)),
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 6.0),
//                                           child: Text(
//                                             breedCategoryModel[index]
//                                                 .subtitleText,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 6.0),
//                                           child: Text(breedCategoryModel[index]
//                                               .breedText),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 6.0),
//                                           child: Text(
//                                             breedCategoryModel[index].priceText,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
