import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider_Setting/provider.dart';
import '../../Tasks_Provide/Tasks_For_provider.dart';
import 'Task_Widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider2 = Provider.of<AppProvider>(context) ;
    var provider = Provider.of<TasksProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            showYears: false,
            initialDate: _selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date){
              setState(() {
                _selectedDate = date;
                provider.retrieveTasks(_selectedDate);
              });
            },
            leftMargin: 20,
            monthColor: provider2.isDark() ?  Colors.white :Colors.black ,
            dayColor: provider2.isDark() ?  Colors.white :Colors.black ,
            dayNameColor: Theme.of(context).primaryColor,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Color(0xFF333A47),
            // selectableDayPredicate: (date) => date.day != 23,
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (buildContext, index) {
                  return TaskWidget(provider.tasks.elementAt(index));
                },
                itemCount: (provider.tasks.length),
                separatorBuilder: (_, __) => SizedBox(
                  height: 8,
                ),
              ))
        ],
      ),
    );
  }
}
/*
StreamBuilder<QuerySnapshot<Task>>(
                stream: MyDataBase.listenForTaskUpdates(),
                builder:(buildContext,snapshot){
                  if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                    // show Try again
                  }else if(snapshot.connectionState ==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  // there
                    var data= snapshot.data?.docs.map((docSnapshot){
                    return docSnapshot.data();
                  },);
                 return  ListView.separated(itemBuilder: (buildContext,index){
                    return TaskWidget(data!.elementAt(index));
                  },itemCount:(data?.length) ??0 ,
                    separatorBuilder: (_,__)=>SizedBox(height: 8,),
                  );
                } ,
              )
 */