import 'package:flutter/cupertino.dart';
import 'package:todo_listapp/models/todo_item.dart';

class ListProvider with ChangeNotifier {
// ignore: non_constant_identifier_names
  List<TodoItem> todoList = [
    // TodoItem("PickupFriend", false),
    // TodoItem("Check-up Appointment @5", false),
    // TodoItem("Buy Grocceries", false),
  ];

  addToDoItem(String title, bool isDone) {
    todoList.add(TodoItem(title, isDone));
    notifyListeners();
  }

  deleteItem(TodoItem item) {
    todoList.remove(item);
    notifyListeners();
  }


  isTaskDone(int i) {
    todoList.elementAt(i).isDone = true;
  }

  List<String> searchResult = [];
  String isSearching = "";
  String searchText = "";

  searchItem(String searchText) {
    searchResult.clear();
    for (var i = 0; i < todoList.length; i++) {
      String data = todoList.elementAt(i).title;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult.add(data);
      }
    }
  }
}
