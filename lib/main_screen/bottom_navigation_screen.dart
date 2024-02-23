// import 'package:flutter/material.dart';
// import 'package:pets_4_home/main_screen/screens/drawer/article_screen.dart';
// import 'package:pets_4_home/main_screen/screens/user/user_screen.dart';
// import 'screens/home/home_screen.dart';
//
// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({Key? key}) : super(key: key);
//
//   @override
//   _BottomBarScreenState createState() => _BottomBarScreenState();
// }
//
// class _BottomBarScreenState extends State<BottomBarScreen> {
//   int _currentIndex = 0;
//   final pages=[
//     const HomeScreen(),
//     const ArticleScreen(),
//     const HomeScreen(),
//     const UserScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.black,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'Article',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'User',
//           ),
//         ],
//       ),
//       body: pages[_currentIndex],
//     );
//   }
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/drawer/article_screen.dart';
import 'package:pets_4_home/main_screen/screens/home/favorite_screen.dart';
import 'package:pets_4_home/main_screen/screens/home/home_screen.dart';
import 'package:pets_4_home/main_screen/screens/user/user_screen.dart';
import 'package:pets_4_home/models/category_model.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int index= 0 ;
  DateTime? lastpress;
  final pages=[
    HomeScreen(),
    const ArticleScreen(),
     FavoriteScreen(),
    const UserScreen(),
  ];
  final items=[
    const Icon(Icons.home,size: 25,),
    const Icon(Icons.article,size: 25,),
    const Icon(Icons.favorite,size: 25,),
    const Icon(Icons.person,size: 25,),
  ];
  Future<bool> onWillPop()async{
    if(index==0){
      if(lastpress == null|| DateTime.now().difference(lastpress!)>const Duration(seconds: 2)){
        lastpress = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("press agian to exit")));
      return false;
      }else{
        return true;
      }

    }else{
      setState(() {
        index=0;
      });
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          extendBody: true,
         bottomNavigationBar: Theme(
           data: Theme.of(context).copyWith(iconTheme: const IconThemeData(color: Colors.white)),
           child: CurvedNavigationBar(
             color: Colors.green.shade700,
             backgroundColor: Colors.transparent,
             buttonBackgroundColor: Colors.green.shade700,
             animationCurve: Curves.easeInOut,
             animationDuration: const Duration(microseconds: 300),

             items: items,
             height: 50,
             index: index,
             onTap: (index) => setState(() => this.index=index),

           ),

         ),
          body: pages[index],
        ),
      ),

    );
  }
}


