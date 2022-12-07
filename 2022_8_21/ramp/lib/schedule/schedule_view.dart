import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:table_calendar/table_calendar.dart";
import '../schedule/event.dart';
import '../schedule/models/db_model.dart';
import '../schedule/models/todo_model.dart';
import '../schedule/widgets/todo_list.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  CalendarFormat format = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late final Function insertFunction;
  late final Function deleteFunction;

  TextEditingController _eventController = TextEditingController();

  //create a database object so we can access database functions
  var db = DatabaseConnect();

  //function to add todo
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  //function to delete todo
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  void initState() {
    selectedDay = DateTime.utc(now.year, now.month, now.day);
    //selectedDay = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("計画を立てる"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekHeight: 20.0,
              rowHeight: 43.0,
              locale: 'ja_JP',
              focusedDay: focusedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
                print(selectedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              //To style the calnedar
              calendarStyle: const CalendarStyle(
                cellMargin: EdgeInsets.all(4),
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(shape: BoxShape.circle),
                weekendDecoration: BoxDecoration(shape: BoxShape.circle),
              ),

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            //list表示
            //...は反復可能なオブジェクトを繰り返してくれる
            //=>は→先をリターンする。

            Todolist(
              insertFunction: addItem,
              deleteFunction: deleteItem,
              selectedDay: selectedDay,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => //Expanded(
                //child: AlertDialog(
                AlertDialog(
                  title: Text("タスクを入力"),
                  content: TextFormField(controller: _eventController),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel")),
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        //何も入力されていなかったら保存しない
                        if (_eventController.text.isEmpty) {
                          print("$focusedDay");
                          print("$selectedDay");
                        } else {
                          //create a todo
                          var myTodo = Todo(
                            title: _eventController.text,
                            creationDate: selectedDay,
                            startTime: now,
                            elapsedTime: 0,
                            isChecked: false,
                            isHabit: false,
                          );
                          // pass this to the insertfunctions as parameter
                          addItem(myTodo);
                          print(myTodo.creationDate);
                        }
                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {});
                        return;
                      },
                    )
                  ],
                  //),
                )),
        //label: Text("追加"),
        //icon: Icon(Icons.add),
        child: Icon(Icons.add),
      ),
    );
  }
}
