import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'date.dart';

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
  final _formKey = GlobalKey<FormState>();
  List<String> itemList = <String>[];
  List<DateTime> dateList = <DateTime>[];
  String currItem;
  DateTime currDate;

  void _addItem(String currItem, DateTime currDate) {
    setState(() {
      itemList.add(currItem);
      dateList.add(currDate);
    });
  }

  void _removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
      dateList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 150,
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Enter To-do list item'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Item cannot be empty';
                              }
                              currItem = value;
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: Text(
                              currDate.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.grey,
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return Container(
                                      child: Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height /
                                            3,
                                        child: CupertinoDatePicker(
                                          onDateTimeChanged:
                                              (DateTime newdate) {
                                            currDate = newdate;
                                          },
                                          initialDateTime:
                                              DateTime(2000 - 07 - 28),
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                          minuteInterval: 5,
                                        ),
                                      ),
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _addItem(currItem, currDate);
                            }
                          },
                          child: Text('Add Item'),
                        ))
                  ])),
        ),
        Container(
            height: 450,
            color: Colors.blue[100],
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Expanded(child: Text('${itemList[index]}')),
                    Expanded(child: Text('${dateList[index]}')),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _removeItem(index);
                          },
                          child: Icon(Icons.remove_circle),
                        ))
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
      ],
    );
  }
}
