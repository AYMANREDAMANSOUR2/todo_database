import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Task(tofirebase&fromfirebase).dart';
import '../../Provider_Setting/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../Utils/Firebase_fireStore(DataBase).dart';

class editScreen extends StatefulWidget {
  static const String routeName = 'edit';
  Task task;
  editScreen(this.task);

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  @override
  // var formKey = GlobalKey<FormState>();
  // var titleController = TextEditingController();
  // var descController = TextEditingController();

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                            )),
                        Text(
                          'To Do List (edit)',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 28),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.20,
                        left: 15,
                        right: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                                'Edit Task',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                          TextFormField(
                            initialValue: widget.task.title,
                            // controller: titleController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter title';
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontSize: 20, color: Theme.of(context).cardColor),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).cardColor)),
                                labelText: AppLocalizations.of(context)!.title_,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 15)),
                            onChanged: (String? value) {
                              widget.task.title = value;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: widget.task.description,
                            style: TextStyle(
                                fontSize: 20, color: Theme.of(context).cardColor),
                            maxLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).cardColor)),
                                labelText: AppLocalizations.of(context)!.desc,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 15)),
                            onChanged: (String? value) {
                              widget.task.description = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     showDateDialog();
                          //   },
                          Column(
                            children: [
                              Text(AppLocalizations.of(context)!.date,
                                  style: Theme.of(context).textTheme.headline3),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    '${widget.task.dateTime!.year}/${widget.task.dateTime!.month}/${widget.task.dateTime!.day}',
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              editTask();
                              provider.refreshApp();
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                  child: Text(
                                    'Save Changes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(fontSize: 20),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  // DateTime selectedDate = DateTime.now();
  // void showDateDialog() async {
  //   DateTime? date = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime.now().add(Duration(days: 365)));
  //   if (date != null) {
  //     selectedDate = date;
  //     setState(() {});
  //   }
  // }
  void editTask() {
    MyDataBase.editTaskDetails(widget.task).then((value) {
      provider.refreshApp();
    });
  }
}