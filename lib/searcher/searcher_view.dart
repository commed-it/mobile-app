import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SearcherView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearcherView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.background.color,
                  theme.lightBackground,
                ]),
          ),
          child: Stack(alignment: AlignmentDirectional.bottomStart,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Column(
                    children: buildSearcherInput()..add(buildRecommendations()),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  List<Widget> buildSearcherInput() {
    return [
      const SizedBox(
        height: 20,
      ),
      StoreConnector<AppState, String>(
        converter: (s) {
          var text2 = s.state.searcher.text;
          _controller.text = text2;
          _controller.selection = TextSelection(
              baseOffset: text2.length, extentOffset: text2.length);
          return text2;
        },
        builder: (ctx, onChanged) => TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.grey.shade600),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
        ),
      ),
      const ListDivider()
    ];
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ));
  }

  Widget buildRecommendations() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Expanded(
        child: SingleChildScrollView(
          child: StoreConnector<AppState, List<String>>(
            converter: (s) => s.state.searcher.historic,
            builder: (ctx, list) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list
                  .asMap()
                  .entries
                  .map((mp) => [
                        buildRecommendation(mp, theme),
                        const ListDivider(),
                      ])
                  .fold([], (value, element) => value..addAll(element)),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildRecommendation(MapEntry<int, String> mp, CommedTheme theme) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildRecommendationText(mp, theme),
            buildDeleteButton(mp, theme),
          ],
        ));
  }

  StoreConnector<AppState, VoidCallback> buildDeleteButton(
      MapEntry<int, String> mp, CommedTheme theme) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (s) => () {
        s.dispatch(DeleteRecommendationIndex(mp.key));
      },
      builder: (ctx, callback) => TextButton(
        onPressed: callback,
        child: Icon(
          Icons.delete,
          color: theme.primary.color,
        ),
      ),
    );
  }

  Widget buildRecommendationText(MapEntry<int, String> mp, CommedTheme theme) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (s) => () {
        s.dispatch(SearcherIs(mp.value));
      },
      builder: (ctx, callback) => TextButton(
        child:
            Text(mp.value, style: TextStyle(color: theme.background.textColor)),
        onPressed: callback,
      ),
    );
  }
}

class _SearcherSomething {
  final String text;
  final StringCallback updateText;

  _SearcherSomething(this.text, this.updateText);
}

typedef StringCallback = void Function(String);
