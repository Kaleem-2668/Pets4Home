
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pets_4_home/controller/change_language.dart';
import 'package:pets_4_home/services/database_helper.dart';
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
  DataBaseHelper dbHelper=DataBaseHelper.instance;

  runApp( MyApp(local:languageCode));
}

class MyApp extends StatelessWidget {
  final String local;
  const MyApp({super.key, required this.local});

  @override
  Widget build(BuildContext context) {

    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>ChangeLanguage())
        ],
        child: Consumer<ChangeLanguage>(
          builder: (context, provider, child){
            if(local.isEmpty){
              provider.changeLanguage(Locale('en'));
            }
            return MaterialApp(
              title: 'Pets4Home',
              locale:local==''? const Locale('en'): provider.appLocale == null ? Locale('en'):provider.appLocale,
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
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
                useMaterial3: true,

              ),
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        )
    );
  }
}