import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Searcher extends StatelessWidget {
  const Searcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Container(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search + AppLocalizations.of(context)!.dots,
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
