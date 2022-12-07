import 'package:flutter/material.dart';
import '../models/db_model.dart';
import './todo_card.dart';

class Todolist extends StatelessWidget {
  //create an object of database connect
  //to pass down to todocard, first our todolist have to receive the functions
  final Function insertFunction;
  final Function deleteFunction;
  final db = DatabaseConnect();

  final DateTime selectedDay;

  Todolist(
      {required this.insertFunction,
      required this.deleteFunction,
      required this.selectedDay,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      //Expanded(
      child: FutureBuilder(
        //FutureBuilder(
        future: db.getTodo(selectedDay.toString()),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var datalength = data!.length;

          return datalength == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Text('タスクがありません'),
                    ])
              : ListView.builder(
                  shrinkWrap: true, //追加
                  physics: const NeverScrollableScrollPhysics(), //追加
                  itemCount: datalength,
                  itemBuilder: (context, i) => Todocard(
                    id: data[i].id,
                    title: data[i].title,
                    creationDate: data[i].creationDate,
                    startTime: data[i].startTime,
                    elapsedTime: data[i].elapsedTime,
                    isChecked: data[i].isChecked,
                    isHabit: data[i].isHabit,
                    insertFunction: insertFunction,
                    deleteFunction: deleteFunction,
                  ),
                );
        },
      ),
    );
  }
}
