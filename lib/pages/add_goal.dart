import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddGoal extends StatefulWidget {
  @override
  _AddGoalState createState() => new _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
//Dialog
  void addedDialog() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Added new goal"),
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
  TextEditingController goalName = new TextEditingController();

//REST API
  void addGoal() {
    var url = "https://proglangrowth.000webhostapp.com/api/addGoals.php";

    http.post(url, body: {
      "GoalName": goalName.text,
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
          title: new Text("Add Goal"),
          backgroundColor: Colors.green,
        ),
        body: new Form(
            key: _formKey,
            child: new ListView(
              padding: new EdgeInsets.all(20.0),
              children: <Widget>[
                new TextFormField(
                  autofocus: false,
                  controller: goalName,
                  decoration: new InputDecoration(
                      hintText: "What's your goal?", labelText: "Goal"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Goal.';
                    }
                  },
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 50.0),
                ),
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addGoal();
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
                      new Text("Add Goal")
                    ],
                  ),
                ),
              ],
            )));
  }
}