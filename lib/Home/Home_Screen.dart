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
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: StadiumBorder(
            side: BorderSide(
                color: Colors.white, width: 4)),
        onPressed: (){
          showAddTaskBottomSheet();
        },
        child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_tf6wSv.json'
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
                icon: Icon(Icons.list),
                label: 'List'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting'
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget>tabs = [TasksListTab(),SettingsTab()];

  void showAddTaskBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return AddTaskBottomSheet();
    });
  }
}