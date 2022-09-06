import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_database/Provider_Setting/provider.dart';
import '../../My_Themes.dart';
import 'Language_sheet(for Function).dart';
import 'Theme_mode_sheet(for Function).dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context) ;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 20.0 , horizontal: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.mode,
              style:
            TextStyle(color:  provider.isDark() ? Colors.white : Colors.black , fontWeight: FontWeight.bold),),
            InkWell(
              onTap: (){
                showbottomsheetthememode() ;
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 10 ),
                child: Container(
                  margin:  EdgeInsets.only(top: 7 ,left: 20),
                  padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: BoxDecoration(
                      color: provider.isDark() ? MyTheme.darkScaffoldBackground :Colors.white ,

                      border: Border.all(color: MyTheme.lightPrimary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      provider.isDark() ?
                      AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light
                      ,style: TextStyle(
                      color:  MyTheme.lightPrimary
                    ),),
                     Icon(Icons.arrow_drop_down_circle_outlined ,  color: MyTheme.lightPrimary,size: 30,),


                  ],),



                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text(AppLocalizations.of(context)!.language,
              style:
            TextStyle(color:  provider.isDark() ? Colors.white : Colors.black , fontWeight: FontWeight.bold),),
            InkWell(
              onTap: (){
                showbottomsheetLang() ;
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 10 ),
                child: Container(
                  margin:  EdgeInsets.only(top: 7 ,left: 20),
                  padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: BoxDecoration(
                      color: provider.isDark() ? MyTheme.darkScaffoldBackground :Colors.white ,
                      border: Border.all(color: MyTheme.lightPrimary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.currentLang == "en" ? 'English' : "العربية"
                        ,style: TextStyle(
                        color:  MyTheme.lightPrimary

                      ),),
                       Icon(Icons.arrow_drop_down_circle_outlined ,
                        color: MyTheme.lightPrimary
                        ,size: 30,),


                    ],),



                ),
              ),
            ),
          ],
        ),


      ),
    );
  }

  showbottomsheetthememode() {
    showModalBottomSheet(context: context,builder: (BuildContext){
      return Themebottomsheet() ;
    });

  }
  showbottomsheetLang() {
    showModalBottomSheet(context: context,builder: (BuildContext){
      return const LanguagebottomSheet() ;
    });

  }

}