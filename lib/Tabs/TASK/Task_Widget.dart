import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../Provider_Setting/provider.dart';
import '../../Tasks_Provide/Tasks_For_provider.dart';
import '../../Utils/Firebase_fireStore(DataBase).dart';
import '../../Utils/Ui_Utils.dart';
import '../../Models/Task(tofirebase&fromfirebase).dart';
import 'Edit task.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var proider = Provider.of<TasksProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (buildContext){
              deleteTask(widget.task);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft:Radius.circular(12)
            ),
            spacing: 12,
          )
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => editScreen(widget.task)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                margin: EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task.title ??"",
                      style:Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:Theme.of(context).primaryColor

                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height:8,),
                    Row(
                      children: [
                        Text(widget.task.description??"",style: Theme.of(context).textTheme.bodySmall,)
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  MyDataBase.Isdone(widget.task);
                  proider.retrieveTasks();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                   padding: EdgeInsets.symmetric(vertical: 5,horizontal:5),
                   child:widget.task.isDone! ? Container(
                      width: 80,
                      height: 50,
                       child: Icon(
                         Icons.check,
                         color: Colors.white,)
                ):Text('done',
                       style: TextStyle(fontSize: 25)),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
//----------------------------------------------------------
  void deleteTask(Task task){
    showLoading(context, 'Loading...');
    var provider = Provider.of<TasksProvider>(context,listen: false);
    MyDataBase.deleteTask(widget.task)
        .then((value){
      provider.retrieveTasks();
      hideLoading(context);
      // call when task is completed
      //----------------------------------------------------------
      showMessage(context, 'Task deleted Successfully from server and local',
          posActionName:'ok');
      //----------------------------------------------------------
    }).onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, 'please try again later',
          posActionName:'i will ');
      //----------------------------------------------------------
    }).timeout(Duration(seconds: 5,),onTimeout: (){
      hideLoading(context);
      provider.retrieveTasks();
      showMessage(context, 'data saved locally ',
          posActionName:'done');
    });
  }
}