import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listapp/provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();
  List<dynamic> list = [];
  late bool isSearching;

  searchListExampleState(model) {
    controller.addListener(() {
      if (controller.text.isEmpty) {
        model.isSearching = false;
        model.searchText = "";
      } else {
        model.isSearching = false;
        model.searchText = controller.text;
      }
    });
  }

  searchBar(model) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 310,
            child:TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (text) {
                setState(() {
                  model.searchItem(text);
                  searchListExampleState(model);
                });
              },
            ),
            // },
          ),
          // ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: Consumer<ListProvider>(builder: (context, model, _) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(model),
                Flexible(
                    child: (model.searchResult.length != 0 ||
                            controller.text.isNotEmpty)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.searchResult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                //leading: ,
                                title: Text(
                                    model.searchResult[index].title.toString()),
                                leading: IconButton(
                                    icon: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.lightBlue,
                                    ),
                                    onPressed: () {
                                      model.isTaskDone(index);
                                      setState(() {
                                        model.searchResult[index].isDone
                                            ? Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.lightBlue,
                                              );
                                      });
                                    }),
                              );
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text("No results found");
                            },
                          ))
              ],
            ),
          );
        }));
  }
}
