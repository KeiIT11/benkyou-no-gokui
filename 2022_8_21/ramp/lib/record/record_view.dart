import 'package:flutter/material.dart';

class RecordView extends StatelessWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント'),
      ),
      body: const Center(
          child: Text('アカウント画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
