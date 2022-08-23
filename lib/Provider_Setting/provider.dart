import 'package:flutter/material.dart';
import 'package:todo_database/Utils/Ui_Utils.dart';
class AppProvider extends ChangeNotifier{

 String currentLang = 'en' ;
ThemeMode currentTheme = ThemeMode.light ;
bool isDark(){
  return currentTheme == ThemeMode.dark ;
}
void changeTheme(ThemeMode newtheme , BuildContext context){
  if(newtheme == currentTheme) return showMessage(context, "u already in this mode choose another one ",posActionName: "ok") ;
  currentTheme = newtheme ;
  notifyListeners() ;

}
//----------------------------------------------------------------------
void changelang(String newlang , BuildContext context){
  if(newlang == currentLang) return showMessage(context, "u already Use this language , please choose another one  ",posActionName: "I will") ;
  currentLang = newlang ;
  notifyListeners() ;
}
}