import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {

    @override
    Widget build(BuildContext context){
      return new Material(
        child: new Container(
        color: Colors.white,
          child: new InkWell(
            onTap: (){Navigator.of(context).popAndPushNamed("/Home");},
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Image.asset("images/logo.png",height: 300.0,),
                      new Text("Welcome to", style: new TextStyle(fontWeight: FontWeight.bold,fontSize:25.0),),
                      new Text("Growth!", style: new TextStyle(fontWeight: FontWeight.bold,fontSize:50.0),),
                      new Padding(padding: new EdgeInsets.only(top:35.0)),
                      new Text("Your Productivity Manager", style: new TextStyle(fontSize:20.0),),
                      new Padding(padding: new EdgeInsets.only(top:120.0)),
                      new Text("Tap anywhere to begin!",style: new TextStyle(fontStyle: FontStyle.italic))
                  ],
                ),
              ),
            ], 
          ),
        ),
      ),
    );
  }
}