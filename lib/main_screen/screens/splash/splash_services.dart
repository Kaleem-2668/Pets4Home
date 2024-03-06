// import 'package:flutter/material.dart';
// import 'package:pets_4_home/models/user_model.dart';
// import 'package:pets_4_home/view_model/auth/user_view_model.dart';
//
// import '../../bottom_navigation_screen.dart';
// import '../auth/login_screen.dart';
//
// class SplashServices {
//   Future<UserModel?> userData() => UserViewModel().loadUser();
//
//   void checkAuthentication(BuildContext context) async {
//     try {
//       UserModel? user = await userData();
//
//       if (user == null || user.data == null || user.data!.authToken == null || user.data!.authToken == '') {
//         // User is not authenticated
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (ctx) => const LoginScreen()),
//         );
//       } else {
//         // User is authenticated
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (ctx) => const BottomBarScreen()),
//         );
//       }
//     } catch (error, stackTrace) {
//       print(error.toString());
//     }
//   }
// }
//
//
