class Todo {
  int? id;
  final String title; //代入不可
  DateTime creationDate;
  DateTime startTime;
  int? elapsedTime;
  bool isChecked;
  bool isHabit;

  //create the constructor
  Todo({
    this.id,
    required this.title,
    required this.creationDate,
    required this.startTime,
    required this.elapsedTime,
    required this.isChecked,
    required this.isHabit,
  });

  //tod save this date in database we need to convert it to a map.
  //let's create a function for that
  Map<String, dynamic> toMap() {
    //dynamicは動的型付け, toMapはインスタンスのデータをMapに変換
    return {
      'id': id,
      'title': title,
      'creationDate': creationDate
          .toString(), //sqlite database doesnt support datetime type
      'startTime': startTime.toString(),
      'elapsedTime': elapsedTime,
      'isChecked': isChecked ? 1 : 0, //it doesnt support the boolean either,
      'isHabit': isChecked ? 1 : 0,
    };
  }

  //this function is for debugging only
  @override
  String toString() {
    return 'Todo(id: $id, title: $title, creationDate :$creationDate, startTime: $startTime,isChecked:$isChecked, isHabit:$isHabit)';
  }
}
