import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listapp/models/todo_item.dart';
import 'package:todo_listapp/provider/provider.dart';
import 'package:todo_listapp/screens/search_screen.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  ToDoScreenState createState() {
    return ToDoScreenState();
  }
}

class ToDoScreenState extends State<ToDoScreen> {
  late GlobalKey<FormState> _formkey;
  late TextEditingController _controller;
  var taskItems;
  bool searchButton = false;
  // TodoItem.length;

  @override
  void initState() {
    super.initState();

    _formkey = GlobalKey();
    _controller = TextEditingController();
  }

  void _showDialog(model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formkey,
          child: AlertDialog(
            title: Text(
              'Add To-Do',
              style: TextStyle(color: Colors.lightBlue),
            ),
            content: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter To-Do',
                fillColor: Colors.lightBlue,
              ),
              controller: _controller,
              validator: (String? val) {
                if (val!.length > 0) {
                  return null;
                } else {
                  return 'Add an item';
                }
              },
              onSaved: (val) =>
                  Provider.of<ListProvider>(context).addToDoItem(val!, false),
            ),
            actions: [
              TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      model.addToDoItem(_controller.text, false);
                    }
                    _controller.clear();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.lightBlue),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ListProvider>(
        builder: (context, model, _) {
          return ListView.builder(
              itemCount: model.todoList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Row(children: [
                        IconButton(
                            onPressed: () async {
                              model.todoList.elementAt(index).isDone = true;
                              setState(() {});
                            },
                            icon: model.todoList.elementAt(index).isDone
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.lightBlue,
                                  ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        model.todoList.elementAt(index).isDone
                            ? Text(
                                model.todoList[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(
                                model.todoList[index].title,
                                style: TextStyle(fontSize: 16),
                              ),
                      ]),
                    ),
                  ),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  key: ValueKey<TodoItem>(model.todoList[index]),
                  onDismissed: (DismissDirection direction) {
                    // setState(() {
                    model.todoList.removeAt(index);
                    // });
                  },
                );
              });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton:
          Consumer<ListProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: FloatingActionButton(
            onPressed: () {
              _showDialog(model);
            },
            // elevation: 1,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 57,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.4,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.dehaze,
                  color: Theme.of(context).primaryColor,
                  size: 27,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Todo",
                  style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    fontSize: 18, fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Theme.of(context).primaryColor,
              iconSize: 27,
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
            // }),
          ],
        ),
      ),
    );
  }
}
