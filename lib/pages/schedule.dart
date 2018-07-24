import 'dart:async';
import 'dart:convert';
import './edit_schedule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Schedule extends StatefulWidget {

   final List list;
  final int index;

  Schedule({this.list, this.index});
  @override
  _ScheduleState createState() => new _ScheduleState();
  
}
class _ScheduleState extends State<Schedule> {
   var refreshKey = new GlobalKey<RefreshIndicatorState>();
    Future<Null> refreshList() async {
        refreshKey.currentState?.show(atTop: false);
         await new Future.delayed(new Duration(seconds: 2));

        setState(() {
          //getSchedule();
        new _ScheduleState();
        });

        return null;
      }

//Alert Dialog

 void deleteAllDialog(){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Clear all schedule?"),
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
            deleteAllSchedule();
            Navigator.pop(context);
            refreshList();
        },
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}
  
//REST API
 Future<List> getSchedule() async {
    final response = await http.get("https://proglangrowth.000webhostapp.com/api/getSchedule.php");
    return json.decode(response.body);
  }

  void deleteAllSchedule(){
  var url="https://proglangrowth.000webhostapp.com/api/deleteAllSchedule.php";
  http.post(url, body: {
    'Archived': "1"
  });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Schedule"),
        backgroundColor: Colors.pinkAccent,
        actions:<Widget>[
                new IconButton(
                  icon: new Icon(Icons.delete,color: Colors.white),
                  tooltip: 'Clear all schedule',
                  onPressed: ()=>deleteAllDialog(),
              ),
               new IconButton(
                 icon: new Icon(Icons.add_circle_outline,color: Colors.white),
                 tooltip: 'Create new schedule',
                 onPressed: (){Navigator.of(context).pushNamed("/add_schedule");},
          ),
        ],
      ),
      body: new RefreshIndicator(
        key: refreshKey,
        onRefresh: ()=>refreshList(),
        child: new FutureBuilder<List>(
          future: getSchedule(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text("Fetching Schedule",style: new TextStyle(fontSize: 25.0,color: Colors.black87),),
                        new Padding(padding: new EdgeInsets.all(20.0),),
                          new CircularProgressIndicator(backgroundColor: Colors.blueGrey,),
                          new Padding(padding: new EdgeInsets.all(15.0),),
                           new Text("Please wait...",style: new TextStyle(fontSize: 20.0,color: Colors.black87),),
                           
                      ],
                    )              
                  );
            },
          ),
        ),
      );
      }
    }

class ItemList extends StatelessWidget {

  

void deleteSchedule(String id){
  var url="https://proglangrowth.000webhostapp.com/api/deleteSchedule.php";
  http.post(url, body: {
    'ScheduleID': id,
    'Archived': "1"
  });
}
  
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {

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
             Navigator.pushReplacementNamed(context, "/schedule");
        },
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}

 void chooseDialog(String id,String name){
  AlertDialog alertDialog = new AlertDialog(
    content: new Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
              new FlatButton(
                onPressed:(){
                  Navigator.pop(context);
                  deleteDialog(id, name);
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child:  new Text("Delete " + name.toLowerCase(),style: new TextStyle(fontSize: 15.0,color: Colors.redAccent),),
                    ),    
                  ],
                ),
              )
            ],
          )
    )
  );

  showDialog(context: context, child: alertDialog);
}

    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(5.0),
          child: new InkWell(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new EditSchedule(list:list , index: i,)
              )
            ),
            onLongPress:()=> chooseDialog(list[i]['ScheduleID'],list[i]['TimeStart'] + " - " + list[i]['TimeStart'] ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['ScheduleName']),
                leading: new Icon(Icons.timer),
                subtitle: new Text(list[i]['TimeStart'] + " - " +list[i]['TimeEnd']),
              ),
            ),
          ),
        );
      },
    );
  }
}
