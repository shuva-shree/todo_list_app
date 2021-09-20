import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:todo_listapp/models/todo_item.dart';
import 'package:todo_listapp/provider/provider.dart';
import 'package:todo_listapp/widgets/bottom_bar.dart';

// ignore: must_be_immutable
class ToDoScreen extends ConsumerWidget {
  late GlobalKey<FormState> _formkey;
  late TextEditingController _controller;
  var taskItems;
  bool searchButton = false;
  bool isAdded = false;
  // TodoItem.length;

  //  _formkey = GlobalKey();
  //   _controller = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  // }

  void _showDialog(getListData, context) {
    isAdded = true;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                      onSaved: (val) {
                        //  final dataItem = watch(getData);

                        if (getListData.isAdded)
                          getListData.addToDoItem(val!, false);

                        // Provider.of<ListProvider>(context).addToDoItem(val!, false),
                      }),
                  actions: [
                    TextButton(
                      child: new Text("Close"),
                      onPressed: () {
                        getListData.isAdded = false;
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (_formkey.currentState!.validate() &&
                                _controller.text.isNotEmpty) {
                              getListData.addToDoItem(_controller.text, false);
                            }
                            _controller.clear();
                            // _controller = TextEditingController();
                            // _formkey = GlobalKey();
                          });
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
        });
  }

  @override
  Widget build(BuildContext context, watch) {
    final getListData = watch(getData);
    _formkey = GlobalKey();
    _controller = TextEditingController();
    return Scaffold(
      body: Consumer(
        builder: (context, model, _) {
          return ListView.builder(
              itemCount: getListData.todoList.length,
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
                            // getListData.todoList.elementAt(index).isDone = true;
                            getListData.isTaskDone(index);
                            // setState(() {});
                          },
                          icon: getListData.todoList.elementAt(index).isDone
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
                        getListData.todoList.elementAt(index).isDone
                            ? Text(
                                getListData.todoList[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(
                                getListData.todoList[index].title,
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
                  key: ValueKey<TodoItem>(getListData.todoList[index]),
                  onDismissed: (DismissDirection direction) {
                    // setState(() {
                    getListData.todoList.removeAt(index);
                    // });
                  },
                );
              });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Consumer(builder: (context, watch, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: FloatingActionButton(
            onPressed: () {
              _showDialog(getListData, context);
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
      bottomNavigationBar: BottomBar(),
    );
  }
}
