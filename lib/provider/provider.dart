import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
import 'package:todo_listapp/models/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getData = ChangeNotifierProvider<ListProvider>((ref) => ListProvider());

class ListProvider with ChangeNotifier {
// ignore: non_constant_identifier_names
  List<TodoItem> todoList = [
    // TodoItem("PickupFriend", false),
    // TodoItem("Check-up Appointment @5", false),
    // TodoItem("Buy Grocceries", false),
  ];
  bool isAdded = false;
  addToDoItem(String title, bool isDone) {
    isAdded = true;
    todoList.add(TodoItem(title, isDone));
    notifyListeners();
  }

  deleteItem(TodoItem item) {
    todoList.remove(item);
    notifyListeners();
  }

  isTaskDone(int i) {
    todoList.elementAt(i).isDone = true;
    notifyListeners();
  }

  List<TodoItem> searchResult = [];
  bool isSearching = false;
  String searchText = "";

  searchItem(String searchText) {
    isSearching = true;
    searchResult.clear();
    for (var i = 0; i < todoList.length; i++) {
      String data = todoList.elementAt(i).title;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult.add(TodoItem(data, todoList.elementAt(i).isDone));
      }
    }
    isSearching = false;
    notifyListeners();
  }
}
