import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listapp/provider/provider.dart';
import 'package:todo_listapp/screens/todo_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.indigoAccent,
      ),
      home: ChangeNotifierProvider<ListProvider>(create: (BuildContext context) => ListProvider()  ,
      child: ToDoScreen()),
    );
  }
}