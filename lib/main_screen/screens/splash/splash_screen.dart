// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pets_4_home/main_screen/screens/splash/splash_services.dart';
// import '../../bottom_navigation_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//    SplashServices splashServices = SplashServices();
//   @override
//   void initState() {
//     super.initState();
//     _initApp();
//      splashServices.checkAuthentication(context);
//   }
//
//   void _initApp() async {
//     var status = await Permission.location.request();
//     await Future.delayed(const Duration(seconds: 3));
//
//     if (status == PermissionStatus.granted) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
//         return const BottomBarScreen();
//       }));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enable location to use our services'),
//         ),
//       );
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SizedBox(
//           // color: const Color(0xff8291f9),
//           width: double.infinity,
//           height: double.infinity,
//           child: Stack(
//             children: [
//               const Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 100,
//                     ),
//                     Text(
//                       'Pets4Home',
//                       style: TextStyle(
//                         fontSize: 24,
//                         height: 1.5,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff2E7D32),
//                         letterSpacing: 0.84,
//
//                       ),
//                     ),
//                     SizedBox(height: 30,),
//                     Text('   Helping You To Keep\nYour Bestie Stay Healthy!',
//                         style: TextStyle(
//                           fontSize: 24,
//                           height: 1.5,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff2E7D32),
//                           letterSpacing: 0.84,
//                         ),
//                     )
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Image.asset('images/splash_image.png'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pets_4_home/main_screen/screens/splash/splash_services.dart';
import '../../bottom_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    var status = await Permission.location.request();
    await Future.delayed(const Duration(seconds: 3));

    if (status == PermissionStatus.granted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return const BottomBarScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location to use our services'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Pets4Home',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2E7D32),
                        letterSpacing: 0.84,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '   Helping You To Keep\nYour Bestie Stay Healthy!',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2E7D32),
                        letterSpacing: 0.84,
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset('images/splash_image.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
