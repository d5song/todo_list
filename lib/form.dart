import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormState();
  }
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  String currItem;
  DateTime currDate;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                                    onDateTimeChanged: (DateTime newdate) {
                                      currDate = newdate;
                                    },
                                    initialDateTime: DateTime(2000 - 07 - 28),
                                    mode: CupertinoDatePickerMode.dateAndTime,
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
                        //MyStatefulWidgetState.addItem(currItem, currDate);
                      }
                    },
                    child: Text('Add Item'),
                  ))
            ]));
  }
}