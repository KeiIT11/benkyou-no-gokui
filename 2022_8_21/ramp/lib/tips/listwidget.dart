import 'package:flutter/material.dart';
import 'shared/itemlist.dart';

Widget listWidget(ListItem item) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20.0),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Hero(
            tag: "${item.id}",
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/${item.name}.jpeg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            width: 7.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
