import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_database/Provider_Setting/provider.dart';
import 'Home/Home_Screen.dart';
import 'My_Themes.dart';
import 'Splash_Screen.dart';
import 'Tasks_Provide/Tasks_For_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (buildContext)=>AppProvider(),
      child: MyApp()));
}
class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => HomeScreen())));
  }
  late  AppProvider provider ; //////////////////////////////

  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context); //////////////
    return ChangeNotifierProvider(
      create: (buildContext)=>TasksProvider(),
      child: MaterialApp(
        locale: Locale(provider.currentLang) ,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English, no country code
          Locale('ar'), // arabic, no country code
        ],
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: provider.currentTheme , ///////
        routes: {
          HomeScreen.routeName : (buildContext)=> HomeScreen() ,
          Splash.routeName : (_) => Splash()
        },
        initialRoute: Splash.routeName,
      ),
    );
  }
}