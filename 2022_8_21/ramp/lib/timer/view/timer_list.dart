import 'package:flutter/material.dart';
import 'package:ramp/timer/view/timer_view.dart';
import "../model/time_list.dart";

class timerList extends StatelessWidget {
  const timerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("勉強する"),
        ),
        body: ListView.builder(
          itemCount: timeList.length,
          itemBuilder: (context, index) {
            timerMinutes time = timeList[index];
            return Card(
              child: ListTile(
                  title: Text(time.title),
                  subtitle: (((time.pomosec.toInt()) / 60).floor() == 0)
                      ? Text(
                          "${((time.pomosec.toInt()) % 60).floor().toString().padLeft(1, "0")}秒勉強 | ${(time.restsec.toInt() % 60).toString().padLeft(1, "0")}秒休憩")
                      : Text(
                          "${((time.pomosec.toInt()) / 60).floor().toString().padLeft(1, "0")}分勉強 | ${((time.restsec.toInt()) / 60).floor().toString().padLeft(1, "0")}分休憩"),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerView(
                                pomosec: time.pomosec, restsec: time.restsec)));
                  }),
            );
          },
        ));
  }
}
