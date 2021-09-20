import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_listapp/screens/todo_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(
    //     providers: providers,
    //     child: 
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.indigoAccent,
          ),
          home: ToDoScreen(),
        );
        // );
  }
}

// List<SingleChildWidget> providers = [
//   ChangeNotifierProvider<ListProvider>(create: (_) => ListProvider()),
// ];
