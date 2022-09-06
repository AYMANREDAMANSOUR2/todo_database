class Task{
  static const String collectionName = 'task';
  String? id;
  String? title;
  String? content;
  DateTime? dateTime;
  String? description;
  bool? isDone;
  Task({this.id,this.title,this.description, this.content,this.dateTime,this.isDone});


  // Task({
  //   required this.id,
  //   required this.title,
  //   required this.content,
  //   required this.dateTime,
  //   required this.time,
  //   this.isDone = false,
  // });



  Task.fromFireStore(Map<String,dynamic> data):
        this(
          id: data['id'],
          title: data['title'],
          content: data['content'],
          description: data['description'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data['isDone']
      );
  Map<String,dynamic> toFireStore(){
    return {
      'id' :id,
      'title':title,
      'description': description,
      'content':content,
      'isDone':isDone,
      'dateTime':dateTime?.millisecondsSinceEpoch
    };
  }

}