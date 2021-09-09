import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_listapp/provider/provider.dart';
import 'package:todo_listapp/screens/todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.indigoAccent,
          ),
          home: ToDoScreen(),
        ));
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ListProvider>(create: (_) => ListProvider()),
];
