import 'package:flutter/material.dart';

class Home extends StatelessWidget{
 @override
 Widget build(BuildContext context){
   return new Material(
     child: new Container(
       child: new Column(
         children: <Widget>[
           new AppBar(
             automaticallyImplyLeading: false,
             title: new Text("Growth"),
             backgroundColor: Colors.deepPurpleAccent,
           ),
           new Container(
             padding: new EdgeInsets.all(20.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 new Card(
                   elevation: 2.0,
                   margin: new EdgeInsets.all(10.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new InkWell(
                            onTap: (){Navigator.of(context).pushNamed("/schedule");},
                            child: new Column(
                              children: <Widget>[
                                 new ListTile(
                                   leading: new Icon(Icons.calendar_today),
                                    contentPadding: new EdgeInsets.all(40.0),
                                    title: new Text('Schedule',textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: new Text('Schedule for the day',textAlign: TextAlign.center,),
                              ),  
                            ],
                         ),  
                      )
                    ],
                  ),
                ),
                      new Card(
                        elevation: 2.0,
                   margin: new EdgeInsets.all(10.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new InkWell(
                            onTap: (){Navigator.of(context).pushNamed("/todo");},
                            child: new Column(
                              children: <Widget>[
                                 new ListTile(
                                   leading: new Icon(Icons.list),
                                    contentPadding: new EdgeInsets.all(40.0),
                                    title: new Text('To Do List',textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: new Text('List of things to do',textAlign: TextAlign.center,),
                              ),  
                            ],
                         ),  
                      )
                    ],
                  ),
                ),
                  new Card(
                  elevation: 2.0,
                   margin: new EdgeInsets.all(10.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new InkWell(
                            onTap: (){Navigator.of(context).pushNamed("/goals");},
                            child: new Column(
                              children: <Widget>[
                                 new ListTile(
                                   leading: new Icon(Icons.accessibility_new),
                                   contentPadding: new EdgeInsets.all(40.0),
                                    title: new Text('Goals',textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: new Text('Goals to reach for the day',textAlign: TextAlign.center,),
                              ),   
                            ],
                         ),  
                      )
                    ],
                  ),
                )              
               ],
             )
           )
         ],
       ),
     ),
   );
 }
}