import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Tasks_Provide/Tasks_For_provider.dart';
import '../../Utils/Firebase_fireStore.dart';
import '../../Utils/Ui_Utils.dart';
import '../../Models/Task(tofirebase&fromfirebase).dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
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
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.task.title}',style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height:8,),
                  Row(
                    children: [
                      Text(widget.task.content??"",style: Theme.of(context).textTheme.bodySmall,)
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
               padding: EdgeInsets.symmetric(vertical: 5,horizontal:5),
              child: Container(
                  width: 80,
                  height: 50,
                  child: InkWell(
                    onTap: (){

                    },
                      child: Lottie.network("https://assets9.lottiefiles.com/datafiles/x4WYMt3Jz674U59/data.json" ,)))
            )
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task){
    showLoading(context, 'Loading...');
    var provider = Provider.of<TasksProvider>(context,listen: false);
    MyDataBase.deleteTask(widget.task)
        .then((value){
      provider.retrieveTasks();
      hideLoading(context);
      // call when task is completed
      showMessage(context, 'Task deleted Successfully',
          posActionName:'ok');
    }).onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, 'please try again later',
          posActionName:'ok');
    }).timeout(Duration(seconds: 5,),onTimeout: (){
      hideLoading(context);
      provider.retrieveTasks();
      showMessage(context, 'data saved locally',
          posActionName:'ok');
    });
  }
}