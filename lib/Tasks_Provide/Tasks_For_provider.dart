import 'package:flutter/material.dart';
import '../Models/Task(tofirebase&fromfirebase).dart';
import '../Utils/Firebase_fireStore(DataBase).dart';
class TasksProvider extends ChangeNotifier{
  List<Task> tasks = [];
  var date = DateTime.now();
  TasksProvider(){
    retrieveTasks();
  }
  void retrieveTasks([DateTime? newDateTime= null])async{
    if(newDateTime!=null) {
      date = newDateTime;
    }
    var tasksQuerySnapshot = await MyDataBase.getTasks(date);
    tasks = tasksQuerySnapshot.docs.map((e) => e.data()).toList(); // to convert from docs to list
    notifyListeners();
  }

}