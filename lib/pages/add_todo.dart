import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  @override
  _AddGoalState createState() =>new _AddGoalState();
}

class _AddGoalState extends State<AddTodo> {
//Dialog
  void addedDialog() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Added new task"),
      actions: <Widget>[
        new RaisedButton(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Close",
                  style: new TextStyle(
                    color: Colors.white,
                  ))
            ],
          ),
          color: Colors.greenAccent,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

//form key
  final _formKey = new GlobalKey<FormState>();

//Textbox
  TextEditingController itemName = new TextEditingController();

//REST API
  void addTodo() {
    var url = "https://proglangrowth.000webhostapp.com/api/addTodo.php";

    http.post(url, body: {
      "ItemName": itemName.text,
      "Status": "pending",
      "Archived": "0"
    });
    addedDialog();
    
  }

//MAIN FORM
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add To Do"),
          backgroundColor: Colors.red,
        ),
        body: new Form(
            key: _formKey,
            child: new ListView(
              padding: new EdgeInsets.all(20.0),
              children: <Widget>[
                new TextFormField(
                  autofocus: false,
                  controller: itemName,
                  decoration:new InputDecoration(
                      hintText: "What needs to be done?", labelText: "Task"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a task.';
                    }
                  },
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 50.0),
                ),
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addTodo();
                    }
                  },
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                          padding:
                              new EdgeInsets.only(top: 20.0, bottom: 20.0)),
                      new Text("Add Task")
                    ],
                  ),
                ),
              ],
            )));
  }
}