import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'itemlist.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailsScreen extends StatelessWidget {
  //const DetailsScreen({Key? key}) : super(key: key);

  final String tag;
  final ListItem item;

  const DetailsScreen({Key? key, required this.item, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0.0,
            title: Text("戻る"),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            //backgroundColor: Colors.white.withOpacity(0.0),
            //elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: "${item.id}",
                        child: Image.asset("assets/images/${item.name}.jpeg")),
                    SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder(
                        future:
                            rootBundle.loadString("assets/md/${item.name}.md"),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Markdown(
                              data: snapshot.data!,
                              styleSheet: MarkdownStyleSheet(
                                h1: TextStyle(fontSize: 24),
                                h2: TextStyle(fontSize: 22),
                                h3: TextStyle(fontSize: 20),
                                h4: TextStyle(fontSize: 18),
                                p: TextStyle(fontSize: 16),
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ],
                ),
              ),
              /*
              Padding(
                padding: EdgeInsets.only(top: 120),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              */
            ],
          )),
    );
  }
}
