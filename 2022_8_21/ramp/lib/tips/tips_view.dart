import 'dart:async';
import 'package:flutter/material.dart';
import 'listwidget.dart';
import 'shared/details.dart';
import 'shared/itemlist.dart';

class TipsView extends StatefulWidget {
  const TipsView({Key? key}) : super(key: key);

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> {
  List<ListItem> listTiles = [
    ListItem(
      "0", //id
      "ramp_solutions", //title
      "このアプリが解決出来る悩み",
      "", //category
    ),
    ListItem(
      "1", //id
      "ramp_future", //title
      "今後のアップデート情報",
      "", //category
    ),
    ListItem(
      "2", //id
      "study-skills", //title
      "効率の良い勉強方法",
      "", //category
    ),
    ListItem(
      "3", //id
      "working-memory", //title
      "ワーキングメモリーの鍛え方＆うまく使う方法",
      "", //category
    ),
    ListItem(
      "4", //id
      "how_to_set_goal", //title
      "モチベの出る目標設定の仕方",
      "", //category
    ),
    ListItem(
      "5", //id
      "how_to_make_schedule", //title
      "挫折しない計画の立て方",
      "", //category
    ),
    ListItem(
      "6", //id
      "how_to_make_habit", //title
      "習慣化のコツ",
      "", //category
    ),
    ListItem(
      "7", //id
      "focus_study", //title
      "集中力を高める方法",
      "", //category
    ),
    ListItem(
      "8", //id
      "investment-by-not-eating", //title
      "食べない投資",
      "", //category
    ),
    ListItem(
      "9", //id
      "investment-by-eating", //title
      "食べる投資",
      "", //category
    ),
    ListItem(
      "10", //id
      "gluten-free", //title
      "グルテンフリー",
      "", //category
    ),
    ListItem(
      "11", //id
      "stomach_health", //title
      "腸内環境を整える方法",
      "", //category
    ),
    ListItem(
      "12", //id
      "type-of-exercise", //title
      "運動で脳機能を高める方法",
      "", //category
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('勉強法を学ぶ'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            itemCount: listTiles.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                                item: listTiles[index],
                                tag: listTiles[index].id,
                              )));
                },
                child: listWidget(listTiles[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
