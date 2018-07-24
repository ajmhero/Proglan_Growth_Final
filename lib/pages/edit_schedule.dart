import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditSchedule extends StatefulWidget {
  final List list;
  final int index;

  EditSchedule({this.list, this.index});
  @override
  _EditScheduleState createState() => new _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
//delete

 void deleteDialog(String id,String name){
  AlertDialog alertDialog = new AlertDialog(
    content:new Container(
      child: new Text("Clear "+ name.toLowerCase() +" schedule?",overflow: TextOverflow.ellipsis,)
    ) ,
    actions: <Widget>[
      new FlatButton(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Close",style: new TextStyle(color: Colors.redAccent,))
          ],
        ),
        onPressed: ()=> Navigator.pop(context),
      ),
      new RaisedButton(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Yes",style: new TextStyle(color: Colors.white,))
          ],
        ),
        color: Colors.green,
        onPressed: (){
            deleteSchedule(id);
            Navigator.pop(context);
             Navigator.pop(context);
             Navigator.pushReplacementNamed(context, "/schedule");
        },
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}

//save
 void savedDialog(){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Saved new schedule"),
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




@override
    void initState() {
      scheduleID = new TextEditingController(text: widget.list[widget.index]['ScheduleID']);
      scheduleName= new TextEditingController(text: widget.list[widget.index]['ScheduleName']);
      timeStart = new TextEditingController(text: widget.list[widget.index]['TimeStart']);
      timeEnd = new TextEditingController(text: widget.list[widget.index]['TimeEnd']);
      super.initState();
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
          timeStart.text = _timeStart.format(context);
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
          timeEnd.text = _timeEnd.format(context);
        });
      }
  }



  TextEditingController scheduleID;
  TextEditingController scheduleName;
  TextEditingController timeStart;
  TextEditingController timeEnd;

//REST API
void deleteSchedule(String id){
  var url="https://proglangrowth.000webhostapp.com/api/deleteSchedule.php";
  http.post(url, body: {
    'ScheduleID': id,
    'Archived': "1"
  });
}

   void editData() {
    var url="https://proglangrowth.000webhostapp.com/api/editSchedule.php";
    http.post(url,body: {
      "ScheduleID": scheduleID.text,
      "ScheduleName": scheduleName.text,
      "TimeStart": timeStart.text,
      "TimeEnd": timeEnd.text
    });
    savedDialog();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit "+ scheduleName.text + " Schedule"),
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
                         new Text(timeStart.text),
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
                         new Text(timeEnd.text),
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
                editData();
              }
            },
            color: Colors.green,
            textColor: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.only(top: 20.0,bottom: 20.0)),
                new Text("Save " + scheduleName.text +" Schedule")
              ],
            ),
          ),
          new Padding(padding: new EdgeInsets.only(top: 15.0,bottom: 15.0),),
          new FlatButton(
            onPressed: ()=> deleteDialog(scheduleID.text, scheduleName.text),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Delete " + scheduleName.text,style: new TextStyle(color: Colors.redAccent),),
            ],
          ),)
         ], 
        ),
      ),
    );
  }
}