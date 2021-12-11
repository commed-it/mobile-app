import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_app/widgets/search.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ChatModel {
  final String image;
  final String title;
  final String subtitle;

  _ChatModel(this.image, this.title, this.subtitle);
}

List<_ChatModel> list = [
  _ChatModel(
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Flogo-semplice-della-tagliatella-piano-marchio-130436365.jpg&f=1&nofb=1",
      "La Bicicleta",
      "50kg of Chicken meat"),
  _ChatModel(
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fofertes.ccoo.cat%2Fwp-content%2Fuploads%2Fsites%2F131%2F2019%2F05%2FRodi_Motor_Services_logo.jpg&f=1&nofb=1",
      "Rodi",
      "Reparation of motors"),
  _ChatModel(
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fofertes.ccoo.cat%2Fwp-content%2Fuploads%2Fsites%2F131%2F2019%2F05%2FRodi_Motor_Services_logo.jpg&f=1&nofb=1",
      "Rodi",
      "inspection of 3242W"),
];

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
                      const Searcher(),
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                      ), ...(list.map((e) => [
                                  buildItem(1,
                                      callback, e.image, e.title, e.subtitle), // TODO: TODO
                                  const ListDivider(),
                                ]))
                            .fold(
                                [],
                                (previousValue,
                                        List<Widget> element) =>
                                    (previousValue as List<Widget>)
                                      ..addAll(element)),
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
