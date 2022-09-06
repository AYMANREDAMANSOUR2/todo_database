import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_database/Utils/Ui_Utils.dart';

import '../Utils/Firebase_fireStore(DataBase).dart';
class AppProvider extends ChangeNotifier{
  String selectedDate = DateFormat.yMMMd().format(DateTime.now());
  String currentLang = 'en' ;
ThemeMode currentTheme = ThemeMode.light ;
//-------------------------------------------------------------------
bool isDark(){
  return currentTheme == ThemeMode.dark ;
}
//---------------------------------------------------------------------
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
//----------------------------------------------------------------------
  void setNewDate(String selectedDate) {
    this.selectedDate = selectedDate;
    notifyListeners();
  }
//-------------------------------------------------------------------------
//   void todoItems() {
//     MyDataBase.getTasksCollection()
//         .where('date', isEqualTo: selectedDate).get().then((document) {
//       items = document.docs.map((element) {
//         return element.data();
//       }).toList();
//       notifyListeners();
//     });
//   }
  //------------------------------------------------------------------
  void set_New_Date(String selectedDate) {
    this.selectedDate = selectedDate;
    notifyListeners();
  }
  //-------------------------------------------------------------------
  void refreshApp() {
    notifyListeners();

  }

}