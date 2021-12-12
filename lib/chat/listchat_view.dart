import 'package:flutter/material.dart';
import 'package:flutter_app/chat/store/actions.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_app/widgets/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models.dart';

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
                  onInit: (sto) => sto.dispatch(loadListChat()),
                  converter: (store) => () {},
                  builder: (ctx, callback) =>
                      StoreConnector<AppState, List<ChatItemModel>>(
                    converter: (sto) => sto.state.listChats,
                    builder: (cto, list) => Column(
                      children: [
                        const Searcher(),
                        list.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                    child: Text(
                                        AppLocalizations.of(ctx)!.no_chats)),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 5),
                              ),
                        ...(list.map((e) => [
                                  StoreConnector<AppState, VoidCallback>(
                                    converter: (sto) => () => sto.dispatch(NavigateToChat(ChatModel(e.idEncounter, e.idEnterprise, e.title, e.image))),
                                    builder: (cto, callback) => buildItem(e.idEnterprise, callback, e.image, e.title,
                                        e.subtitle),
                                  ), // TODO: TODO
                                  const ListDivider(),
                                ]))
                            .fold(
                                [],
                                (previousValue, List<Widget> element) =>
                                    (previousValue as List<Widget>)
                                      ..addAll(element)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StoreConnector<AppState, VoidCallback> buildItem(int userId,
      VoidCallback callback, String image, String title, String subtitle) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (sto) => () => sto.dispatch(loadEnterprise(userId)),
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
