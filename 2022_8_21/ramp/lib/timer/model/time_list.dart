import 'package:flutter/material.dart';

class timerMinutes {
  double pomosec;
  double restsec;
  String title;
  String description;

  timerMinutes({
    required this.pomosec,
    required this.restsec,
    required this.title,
    required this.description,
  });
}

List<timerMinutes> timeList = [
  timerMinutes(
    pomosec: 10,
    restsec: 10,
    title: "１０秒だけ頑張る(やる気ブースト)",
    description: "１０秒から始めてみよう",
  ),
  timerMinutes(
    pomosec: 25 * 60,
    restsec: 5 * 60,
    title: "ポモドーロテクニック(おすすめ)",
    description: "初心者向け(おすすめ)",
  ),
  timerMinutes(
    pomosec: 50 * 60,
    restsec: 15 * 60,
    title: "有能社員のパターン",
    description: "中級者向け",
  ),
  timerMinutes(
    pomosec: 90 * 60,
    restsec: 20 * 60,
    title: "ウルトラディアンリズム",
    description: "上級者向け",
  ),
];
