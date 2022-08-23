import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../My_Themes.dart';
import '../../Provider_Setting/provider.dart';
class LanguagebottomSheet extends StatefulWidget {
  const LanguagebottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguagebottomSheet> createState() => _LanguagebottomSheetState();
}

class _LanguagebottomSheetState extends State<LanguagebottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider  = Provider.of<AppProvider>(context) ;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: Column(children: [
          InkWell(
              onTap: (){
                provider.changelang("en", context);
              },
              child: provider.currentLang == "en"
                  ?getselectedrow("English")
                  : getunselectedRow("English")
          ),
          SizedBox(height: 30,) ,
          InkWell(
              onTap: (){
                provider.changelang("ar", context);
              },
              child: provider.currentLang == "ar"
                  ?getselectedrow("العربية")
                  : getunselectedRow("العربية")
          ),

        ],),




      ),
    );
  }

  Widget getselectedrow( String text ){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.red),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.5,
              0.4,
            ],
            colors: [
              Colors.blue,
              Colors.green,
            ],
          )
      ) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text , style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 25),),
          Icon(Icons.check_circle ,  color: MyTheme.lightPrimary,size: 30,),

        ],),
    );


  }

  Widget getunselectedRow(String text){
    return Container(

      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black , )
      ) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text , style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 25),),
          Icon(Icons.check_circle ,  color: MyTheme.lightPrimary,size: 30,),

        ],),
    );
  }
}
