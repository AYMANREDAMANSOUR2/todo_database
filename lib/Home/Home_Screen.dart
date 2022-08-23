import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Tabs/TASK/Add_task_from_button.dart';
import '../Tabs/TASK/Task(List with calender).dart';
import '../Tabs/settings/Setting_Tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 0,
          shape: StadiumBorder(
              side: BorderSide(
                  color: Colors.white, width: 1)),
          onPressed: (){
            showAddTaskBottomSheet();
          },
          child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_6JcVlW.json',
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex = index;
              setState(() {

              });
            },
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Lottie.network("https://assets2.lottiefiles.com/packages/lf20_msy5e6qj.json",width: 100,height: 45),
                  label: 'List'
              ),
              BottomNavigationBarItem(
                  icon: Lottie.network("https://assets3.lottiefiles.com/packages/lf20_jhagciag.json",width: 100),
                  label: 'Setting'
              ),
            ],
          ),
        ),
        body: tabs[selectedIndex],
      ),
    );
  }

  List<Widget>tabs = [TasksListTab(),SettingsTab()];

  void showAddTaskBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return AddTaskBottomSheet();
    });
  }
}