import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/models/article_model.dart';

class ArticleInfo extends StatefulWidget {
  ArticleInfo({Key? key ,required this.articleModelList}) : super(key: key);
  ArticleModel? articleModelList;

  @override
  _ArticleInfoState createState() => _ArticleInfoState();
}

class _ArticleInfoState extends State<ArticleInfo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(widget.articleModelList!.imageUrl.toString())),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:13.0),
              child: Text(
                'Important announcement:\nchanges ti American Bully Xl\nadverts on Pets4Homes',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.articleModelList!.titleText,style: const TextStyle(fontWeight: FontWeight.bold),),
                  Text(widget.articleModelList!.trailingText)
                ],
              ),
            ),

            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Text(widget.articleModelList!.subtitleText),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 13.0),
            //   child: Row(
            //     children: [
            //     InkWell(
            //                 onTap: (){},
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(15),
            //                     color: Colors.green.shade100,
            //                   ),
            //                   child: const Padding(
            //                     padding: EdgeInsets.symmetric(horizontal: 6.0),
            //                     child: Text('DOGS'),
            //                   ),
            //                 ),
            //               ),
            //       SizedBox(width: 10,),
            //       InkWell(
            //         onTap: (){},
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             color: Colors.green.shade100,
            //           ),
            //           child: const Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 6.0),
            //             child: Text('GENERAL'),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 10,),
            //       InkWell(
            //         onTap: (){},
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             color: Colors.green.shade100,
            //           ),
            //           child: const Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 6.0),
            //             child: Text('BREED FACTS'),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 10,),
            //       Text('15 Dec 2023'),
            //
            //
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
      floatingActionButton: FabCircularMenuPlus(
        fabColor: Colors.green.shade800,
        fabOpenIcon: const Icon(Icons.share, color: Colors.white),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white),
        ringColor: Colors.green.shade700,
        ringDiameter:200,
        children: [
          IconButton(icon: const Icon(Icons.home,color: Colors.white), onPressed: () {
          }),
          IconButton(icon: const Icon(Icons.facebook,color: Colors.white), onPressed: () {

          }),
          IconButton(icon: const Icon(Icons.person,color: Colors.white), onPressed: () {

          }),
          IconButton(icon: const Icon(Icons.favorite,color: Colors.white), onPressed: () {
          })
        ],
      ),

    );
  }
}
