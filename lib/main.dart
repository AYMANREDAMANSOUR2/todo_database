import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home/Home_Screen.dart';
import 'My_Themes.dart';
import 'Tasks_Provide/Tasks_For_provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (buildContext)=>TasksProvider(),
      child: MaterialApp(
        theme: MyTheme.lightTheme,
        routes: {
          HomeScreen.routeName : (buildContext)=> HomeScreen()
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}