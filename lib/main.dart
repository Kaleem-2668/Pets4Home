
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pets_4_home/provider/language_provider.dart';
import 'package:pets_4_home/services/database_helper.dart';
import 'package:pets_4_home/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'main_screen/screens/splash/splash_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode=sp.getString('language_code')?? '';
  final dbHelper= await DataBaseHelper.instance.initializeDataBase();
  runApp( MyApp(local:languageCode));
}

class MyApp extends StatelessWidget {
  final String local;
  const MyApp({super.key, required this.local});

  @override
  Widget build(BuildContext context) {

    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>ChangeLanguage()),
          ChangeNotifierProvider(create: (_)=>AuthViewModel()),
          // ChangeNotifierProvider(create: (_)=>UserViewModel()),
        ],
        child: Consumer<ChangeLanguage>(
          builder: (context, provider, child){
            if(local.isEmpty){
              provider.changeLanguage(const Locale('en'));
            }
            return MaterialApp(
              title: 'Pets4Home',
              locale:local==''? const Locale('en'): provider.appLocale ?? const Locale('en'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
                useMaterial3: false,

              ),
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        )
    );
  }
}
