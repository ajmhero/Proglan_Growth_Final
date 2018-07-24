import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import './pages/home.dart';
import './pages/schedule.dart';
import './pages/goals.dart';
import './pages/todo.dart';
import './pages/add_schedule.dart';
import './pages/add_goal.dart';
import './pages/add_todo.dart';
import './pages/edit_schedule.dart';


void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LandingPage(),
      routes: <String, WidgetBuilder>{
        "/Home": (BuildContext context) => new Home(),
        "/schedule": (BuildContext context) => new Schedule(),
        "/goals": (BuildContext context) => new Goals(),
        "/todo": (BuildContext context) => new TodoList(),
        "/add_schedule": (BuildContext context) => new AddSchedule(),
        "/add_goal": (BuildContext context) => new AddGoal(),
        "/add_todo": (BuildContext context) => new AddTodo(),
        "/edit_schedule": (BuildContext context) => new EditSchedule(),
      }));
}