import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final Function addItem;
  MyForm(this.addItem);

  @override
  State<StatefulWidget> createState() {
    return MyFormState(addItem);
  }
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  final Function addItem;
  final inputItem = TextEditingController();

  String currItem;
  DateTime currDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, 0);

  clearTextInput() {
    inputItem.clear();
  }

  MyFormState(this.addItem);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: inputItem,
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
                  MaterialButton(
                    child: Text(
                      //TODO: Get this to be a faster update?
                      currDate.toString().substring(0, 16),
                      style: TextStyle(color: Colors.black54),
                    ),
                    color: Colors.grey[100],
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
                                  initialDateTime: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      DateTime.now().hour,
                                      0),
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
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addItem(currItem, currDate);
                      }
                      clearTextInput();
                    },
                    child: Text('Add Item'),
                  ))
            ]));
  }
}
