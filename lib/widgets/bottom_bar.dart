import 'package:flutter/material.dart';
import 'package:todo_listapp/screens/search_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
