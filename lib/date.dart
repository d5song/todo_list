import 'package:flutter/cupertino.dart';

import 'main.dart';

class Date extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateState();
  }
}

class DateState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      //width: 200.0,
      child: CupertinoDatePicker(
        onDateTimeChanged: (DateTime newdate) {
          return newdate;
        },
        initialDateTime: DateTime.now(),
        //minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
      ),
    );
  }
}
