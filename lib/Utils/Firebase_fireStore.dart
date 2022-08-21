import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Task(tofirebase&fromfirebase).dart';
import '../ToGetDataOnly.dart';

class MyDataBase {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance //to get the database from firestore
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot, options) { return Task.fromFireStore(snapshot.data() ??{});},
        toFirestore: (task, options) {return task.toFireStore();});
  }
//-----------------------------------------------------------
  static Future<void> addTask(Task task) {
    var taskDoc = getTasksCollection()
        .doc();
    task.dateTime = dateOnly(task.dateTime!);
    task.id = taskDoc.id; //to create id automatic
    return taskDoc.set(task);
  }
  //----------------------------------------------------------
  static Future<QuerySnapshot<Task>> getTasks(
      DateTime dateTime)async{
    var collection = getTasksCollection()
        .where('dateTime',isEqualTo: dateOnly(dateTime).millisecondsSinceEpoch);
    return collection.get();
  }
  //--------------------------------------------------------------
  static Future<void>deleteTask(Task task){
    var tasksCollection = getTasksCollection(); //to get the data
    var taskRef = tasksCollection.doc(task.id);
    return taskRef.delete();
  }
  //----------------------------------------------------------------
  static  Stream<QuerySnapshot<Task>>listenForTaskUpdates(){
    var collection = getTasksCollection();
    return collection.snapshots();
  }

}