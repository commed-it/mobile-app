import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/box_decoration.dart';

class Searcher extends StatelessWidget {
  const Searcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Container(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(
                Icons.search, color: Colors.grey.shade600, size: 20,),
              border : buildOutlineInputBorder(),
              enabledBorder: buildOutlineInputBorder(),
            ),
          ),
        ),
      )
    ;
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.grey.shade400,
                )
            );
  }
}
