

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:todo_listapp/provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// ignore: must_be_immutable
class SearchScreen extends ConsumerWidget {
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

Widget searchBar(getSearchData,context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 310,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (text) {
                // setState(() {
                  getSearchData.searchItem(text);
                  searchListExampleState((getSearchData));
                // });
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
  Widget build(BuildContext context,watch) {
    final getSearchData = watch(getData);
    return Scaffold(
        key: globalKey,
        body: Consumer(builder: (context, model, _) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(getSearchData,context),
                Flexible(
                    child: ( getSearchData.searchResult.length != 0 ||
                            controller.text.isNotEmpty)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount:  getSearchData.searchResult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                //leading: ,
                                title: Text(
                                     getSearchData.searchResult[index].title.toString()),
                                leading: IconButton(
                                    icon: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.lightBlue,
                                    ),
                                    onPressed: () {
                                       getSearchData.isTaskDone(index);
                                      // setState(() {
                                        getSearchData.searchResult[index].isDone
                                            ? Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.lightBlue,
                                              );
                                      // });
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
