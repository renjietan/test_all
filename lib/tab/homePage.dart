import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:test_all/components/jhPickerTool.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  showPicker(BuildContext context) {
    var aa = ["11", "22", "33", "44"];
//       var aa =  [11,22,33,44];

    JhPickerTool.showStringPicker(context, data: aa,
//           normalIndex: 2,
//           title: "请选择2",
        clickCallBack: (int index, var str) {
      print(index);
      print(str);
    });
  }

  final pickerData = '''
[
    [
        1,
        2,
        3,
        4
    ],
    [
        11,
        22,
        33,
        44
    ],
    [
        "aaa",
        "bbb",
        "ccc"
    ]
]
    ''';
  @override
  Widget build(BuildContext context) {
    // Picker picker = new Picker(
    //     adapter: PickerDataAdapter<String>(
    //         pickerdata: new JsonDecoder().convert(pickerData)),
    //     changeToFirst: true,
    //     textAlign: TextAlign.left,
    //     columnPadding: const EdgeInsets.all(8.0),
    //     onConfirm: (Picker picker, List value) {
    //       print(value.toString());
    //       print(picker.getSelectedValues());
    //     });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/bloc_page");
              },
              child: Text("bloc"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/isolate_page");
              },
              child: Text("isolate_page"),
            ),
            FlatButton(
                onPressed: () {
                  showPicker(context);
                },
                child: Text("flutter_picker")),
            SelectionMenu<String>(
              itemsList: <String>['A', 'B', 'C'],
              onItemSelected: (String selectedItem) {
                print(selectedItem);
              },
              itemBuilder: (BuildContext context, String item,
                  OnItemTapped onItemTapped) {
                return Material(
                  child: InkWell(
                    onTap: onItemTapped,
                    child: Text(item),
                  ),
                );
              },
              // other Properties...
            )
          ],
        ),
      ),
    );
  }
}
