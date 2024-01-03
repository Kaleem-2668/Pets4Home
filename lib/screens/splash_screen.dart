// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: const Color(0xff8291f9),
//           width: double.infinity,
//           height: double.infinity,
//           child: Stack(
//             children: [
//               const Center(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 100,),
//                     Text(
//                       'Pets4Home',
//                       style: TextStyle(
//                         fontSize: 24,
//                         height: 1.5,
//                         fontWeight: FontWeight.normal,
//                         color: Color(0xFFDEE1FE),
//                         letterSpacing: 0.84,
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Text(
//                       'Helping you \nto keep your bestie \nstay healthy!',
//                       style: TextStyle(
//                         fontSize: 24,
//                         height: 1.5,
//                         fontWeight: FontWeight.normal,
//                         color: Color(0xFFDEE1FE),
//                         letterSpacing: 0.84,
//                       ),
//                     ),
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
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Request location permission
//           LocationPermission permission = await Geolocator.requestPermission();
//
//           if (permission == LocationPermission.denied) {
//             // Handle when location permission is denied
//             print('Location permission denied');
//           } else if (permission == LocationPermission.deniedForever) {
//             // Handle when location permission is permanently denied
//             print('Location permission permanently denied');
//           } else {
//             // Location permission granted
//             Position position = await Geolocator.getCurrentPosition();
//             print('User Location: ${position.latitude}, ${position.longitude}');
//           }
//         },
//         child: const Icon(Icons.location_on),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pets_4_home/screens/home/home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx){
        return const HomeScreen();
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xff8291f9),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Text(
                      'Pets4Home',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFDEE1FE),
                        letterSpacing: 0.84,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Helping you \nto keep your bestie \nstay healthy!',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFDEE1FE),
                        letterSpacing: 0.84,
                      ),
                    ),
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

