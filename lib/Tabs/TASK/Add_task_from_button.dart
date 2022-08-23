
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Tasks_Provide/Tasks_For_provider.dart';
import '../../Utils/Firebase_fireStore(DataBase).dart';
import '../../Utils/Ui_Utils.dart';
import '../../Models/Task(tofirebase&fromfirebase).dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>(); //for validation
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height:  MediaQuery.of(context).size.height*.7,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey, // to make us use validator
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Add Task'),
              TextFormField(
                controller: titleController,
                validator: (currentText){
                  if(currentText==null||currentText.trim().isEmpty){
                    return 'please enter title';
                  }
                  return null; // in case the validator pass the condition
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: descController, // to get the value or the text from the details
                validator: (text){ // again we use validator here
                  if(text==null||text.isEmpty){
                    return 'please enter details';
                  }
                  return null;
                },
                minLines: 4,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Details',
                ),
              ),
              InkWell(
                onTap: (){
                  showDatePickerDialog(); // to show the date picker to choose the data
                },
                child: Container(
                    padding: const EdgeInsets.all(12),
                    // how to format datetime in dart -> intl
                    //"yyyy/MM/dd"
                    child: Text('${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ),
              ElevatedButton(
                  style:ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Theme.of(context).primaryColor)
                          )
                      )
                  ),
                  onPressed: (){
                    validateForm();
                  }, child:const Text('Add',style: TextStyle(fontSize: 18),) )
            ],
          ),
        ),
      ),
    );
  }
  void validateForm()async{
    var provider = Provider.of<TasksProvider>(context,listen: false);
    if(formKey.currentState?.validate()==true){
      // title, desc,date
      String title = titleController.text;
      String desc = descController.text;
//--------------------------------------------------------------
      var newTask = Task(
          title: title,
          dateTime: selectedDate,
          content: desc,
          isDone: false);
      // Id we will take it from the doc that we already create it
      showLoading(context,'Loading...',isCancelable: false);
      MyDataBase.addTask(newTask)  //To add the task which i input it
      //---------------------------------------------------------------
          .then((value) { // it will happen when future complete
        provider.retrieveTasks(); // to make the the ui restart when i add task
        hideLoading(context);
        showMessage(context, 'task added successfully locally and firebase',
            posActionName: 'ok',posActionCallBack: (){
              Navigator.pop(context);


            });
//---------------------improve accessibility-------------------------------------------
//        Navigator.pop(context);
      }).onError((error, stackTrace) { // when future fails
        hideLoading(context);
        showMessage(context, error.toString());
//-------------------------------------------------------------
      }).timeout(const Duration(seconds: 10),onTimeout:() {
        hideLoading(context);
        provider.retrieveTasks();
        showMessage(context, 'Error connecting to server,''please try again',posActionName: ' I Will');
//----------------------------------------------------------------
      },).timeout(const Duration(seconds: 5,),onTimeout: (){
        hideLoading(context);
        showMessage(context, 'task added locally', posActionName:'ok');
      });
    }
  }
  //--------------------------------------------------
  var titleController = TextEditingController();
  var descController = TextEditingController();
  //----------------------------------------------------
  DateTime selectedDate = DateTime.now();
  void showDatePickerDialog()async
  {
    DateTime? dateTime = await showDatePicker(context: context,
        initialDate: selectedDate, // last data
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if(dateTime!=null){ //check if user didn't select anything
      selectedDate = dateTime;
      setState(() {});
    }
  }
}