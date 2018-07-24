import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => new _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  //alert dialog

  void addedDialog(){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Added new schedule"),
    actions: <Widget>[
      new RaisedButton(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Close",style: new TextStyle(color: Colors.white,))
          ],
        ),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}


  //form key
  final _formKey = new GlobalKey<FormState>();
  
  //Time Picker
  TimeOfDay _timeStart = new TimeOfDay.now();
  TimeOfDay _timeEnd = new TimeOfDay.now();
  //picker function

  //pick start
  Future<Null> _selectTimeStart(BuildContext context) async{
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _timeStart,
    );
      if(time != null && time != _timeStart){
        setState((){
          _timeStart = time;
        });
      }
  }
    //picker TimeENd
  Future<Null> _selectTimeEnd(BuildContext context) async{
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _timeEnd,
    );
      if(time != null && time != _timeEnd){
        setState((){
          _timeEnd = time;
        
        });
      }
  }


  //Textbox
  TextEditingController scheduleName = new TextEditingController();
  TextEditingController timeStart = new TextEditingController();
  TextEditingController timeEnd = new TextEditingController();

  //REST API
  void addSchedule(){
    var url = "https://proglangrowth.000webhostapp.com/api/addSchedule.php";

    http.post(url,body: {
      "ScheduleName" : scheduleName.text,
      "TimeStart" : _timeStart.format(context).toString(),
      "TimeEnd" : _timeEnd.format(context).toString(),
      "Archived" : "0"
    });
    addedDialog();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Schedule"),
        backgroundColor: Colors.blueAccent,
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
          padding: new EdgeInsets.all(20.0),
         children: <Widget>[
           new TextFormField(
             autofocus: false,
             controller: scheduleName,
             decoration: new InputDecoration(
               hintText: "Schedule Name", labelText: "Schedule Name"),
               validator: (value){
                 if(value.isEmpty){
                   return 'Please Fill in the Fields';
                 }
               },
           ),
           new Padding(padding: new EdgeInsets.only(top:30.0)),
           new Column(
           children: <Widget>[
            new Row(
                 children: <Widget>[
                   new Text("Time Start: "),
                   new Padding(padding: new EdgeInsets.only(right: 10.0),),
                    new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   new RaisedButton(
                     onPressed: (){_selectTimeStart(context);},
                     textColor: Colors.white,
                     color: Colors.orange,
                     child: new Row(
                       children: <Widget>[
                         new Text(_timeStart.format(context))
                       ],
                     ),
                   )
                 ]),
              ]),   
           ],
          ),
            new Padding(padding: new EdgeInsets.only(top:30.0)),
           new Column(
           children: <Widget>[
            new Row(
                 children: <Widget>[
                   new Text("Time End: "),
                   new Padding(padding: new EdgeInsets.only(right: 10.0),),
                    new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   new RaisedButton(
                     onPressed: (){_selectTimeEnd(context);},
                     textColor: Colors.white,
                     color: Colors.deepOrangeAccent,
                     child: new Row(
                       children: <Widget>[
                         new Text(_timeEnd.format(context))
                       ],
                     ),
                   )
                 ]),
              ]),   
           ],
          ),
          new Padding(padding: new EdgeInsets.only(top: 50.0),),
          new RaisedButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                addSchedule();
              }
            },
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.only(top: 20.0,bottom: 20.0)),
                new Text("Add Schedule")
              ],
            ),
          )
         ], 
        ),
      ),
    );
  }
}