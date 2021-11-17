import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_app/widgets/search.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cto, theme) => Column(
        children: [
          Expanded(
            child: Container(
              color: theme.background.color,
              child: SingleChildScrollView(
                child: StoreConnector<AppState, VoidCallback>(
                  // TODO change action
                  converter: (store) => () => store.dispatch(LambdaAction((s) =>
                      s.copy(
                          navigatorKey: s.navigatorKey
                            ..currentState!.pushNamed(Routes.chat)))),
                  builder: (ctx, callback) => Column(
                    children: [
                      Searcher(),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      buildItem(
                          callback,
                          "https://images.dog.ceo/breeds/boxer/n02108089_15702.jpg",
                          "Moniation",
                          "Subtitle"),
                      const ListDivider(),
                      buildItem(callback,
                          "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg",
                          "Chicken on the corn", "Anther subtitle"),
                     const ListDivider(),
                      buildItem(callback,
                          "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg",
                          "Chick Korea", "Just a subtitle"),
                     const ListDivider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StoreConnector<AppState, VoidCallback> buildItem(
      VoidCallback callback, String image, String title, String subtitle) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (sto) => () => sto.dispatch(NavigateToEnterpriseDetail(1)),
      builder: (c, callbackLogo) => GenSummaryButton.only(
        ratio: 0.8,
        image: NetworkImage(image),
        title: title,
        subtitle: subtitle,
        onPressed: callback,
        onPressedLogo: callbackLogo,
      ),
    );
  }
}
