import 'package:flutter/material.dart';

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
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  List<String> growableList = <String>["1a", "2b", "3c"];

  void _addItem(String currItem) {
    setState(() {
      growableList.add(currItem);
    });
  }

  void _removeItem(int index) {
    setState(() {
      growableList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 130,
          //color: Colors.red[500],
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Enter To-do list item'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Item cannot be empty';
                        }
                        _addItem(value);
                        return null;
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //_addItem(currItem);
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
              itemCount: growableList.length,
              itemBuilder: (BuildContext context, int index) {
                // return Container(
                //   height: 50,
                //   color: Colors.blue[400],
                //   child: Center(child: Text('${growableList[index]}')),
                // );
                return Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Expanded(child: Text('${growableList[index]}')),
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
