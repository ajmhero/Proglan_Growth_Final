import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {

  final List list;
  final int index;
  TodoList({this.list, this.index});

  @override
  _TodoState createState() => new _TodoState();
}

class _TodoState extends State<TodoList> {

    //REFRESHER
    var refreshKey = new GlobalKey<RefreshIndicatorState>();
    Future<Null> refreshList() async {
        refreshKey.currentState?.show(atTop: false);
         await new Future.delayed(new Duration(seconds: 2));

        setState(() {
        new _TodoState();
        });

        return null;
      }

  //REST API
  Future<List> getTodo() async {
    final response = await http
        .get("https://proglangrowth.000webhostapp.com/api/getTodo.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("To Do List"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add_circle_outline, color: Colors.white),
            tooltip: 'Create new Task',
            onPressed: () {
              Navigator.of(context).pushNamed("/add_todo");
            },
          )
        ],
      ),
      body: new RefreshIndicator(
        key: refreshKey,
        onRefresh: ()=>refreshList(),
        child: new FutureBuilder<List>(
          future: getTodo(),
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
                        new Text("Fetching tasks",style: new TextStyle(fontSize: 25.0,color: Colors.black87),),
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

   void updateTask(String id,String name){
  var url="https://proglangrowth.000webhostapp.com/api/editTodo.php";
  http.post(url, body: {
    'ToDoID': id,
    'ItemName':name ,
    'Status':"Complete",
    'Archived': "0"
  });
}

  void deleteTodo(String id) {
    var url = "https://proglangrowth.000webhostapp.com/api/deleteTodo.php";
    http.post(url, body: {'ToDoID': id, 'Archived': "1"});
  }

  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
 void updateDialog(String id,String name){
   print(id + name);
      AlertDialog alertDialog = new AlertDialog(
        
        content: new Text("Update "+ name.toLowerCase() +" goal?"),
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
                updateTask(id,name);
                Navigator.pop(context);
                Navigator.popAndPushNamed(context,"/todo");
            },
          ),
        ],
      );

    showDialog(context: context, child: alertDialog);
}




    void deleteDialog(String id, String name) {
      AlertDialog alertDialog = new AlertDialog(
        content: new Text("Clear " + name.toLowerCase() + " Task?"),
        actions: <Widget>[
          new FlatButton(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Close",
                    style: new TextStyle(
                      color: Colors.redAccent,
                    ))
              ],
            ),
            onPressed: () => Navigator.pop(context),
          ),
          new RaisedButton(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Yes",
                    style: new TextStyle(
                      color: Colors.white,
                    ))
              ],
            ),
            color: Colors.green,
            onPressed: () {
              deleteTodo(id);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, "/todo");
            },
          ),
        ],
      );

      showDialog(context: context, child: alertDialog);
    }

    void chooseDialog(String id, String name){
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
                      child:  new Text("Delete " + name.toLowerCase(),style: new TextStyle(fontSize: 20.0,color: Colors.redAccent),),
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
          onTap: ()=>updateDialog(list[i]['ToDoID'], list[i]['ItemName']),
            onLongPress: () =>
                deleteDialog(list[i]['ToDoID'], list[i]['ItemName']),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['ItemName']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text(list[i]['Status']),
                
              ),
            ),
          ),
        );
      },
    );
  }
}