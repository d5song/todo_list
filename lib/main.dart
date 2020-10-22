import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = "To-Do List";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: _MyStatefulWidget(),
      ),
    );
  }
}

class _MyStatefulWidget extends StatefulWidget {
  _MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  //TODO: Make this be an automatically sorted list?
  List<String> itemList = <String>[];
  List<DateTime> dateList = <DateTime>[];
  bool sorted = false;

  void addItem(String currItem, DateTime currDate) {
    setState(() {
      itemList.add(currItem);
      dateList.add(currDate);
    });
  }

  void removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
      dateList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: MyForm(addItem),
        ),
        Container(
            height: 50,
            width: 100,
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () {
                  sorted = !sorted;
                },
                child: sorted
                    ? Icon(Icons.arrow_drop_down)
                    : Icon(Icons.format_list_bulleted))),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(child: Text('${itemList[index]}')),
                  Expanded(child: Text('${dateList[index]}'.substring(0, 16))),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: ElevatedButton(
                        onPressed: () {
                          removeItem(index);
                        },
                        child: Icon(Icons.remove_circle),
                      ))
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }
}
