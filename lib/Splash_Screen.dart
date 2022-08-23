import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_database/Home/Home_Screen.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const String routeName = 'splash' ;
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), spla ) ;
  }
  void spla(){
    Navigator.pushNamed(context, HomeScreen.routeName) ;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(image:
        DecorationImage(image: AssetImage('photos/wallpaperflare.com_wallpaperssss.jpg'))),
        //----------------------------------------------
      )

    );
  }
}
