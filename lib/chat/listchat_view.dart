import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
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
      "https://instagram.fbcn5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/25024378_169126683844186_21293180838215680_n.jpg?_nc_ht=instagram.fbcn5-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=jVg3B7QJJo0AX9zxkms&edm=ABfd0MgBAAAA&ccb=7-4&oh=4731660aa270050f2805bb12fd3a2a97&oe=6196859C&_nc_sid=7bff83",
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
                                  buildItem(
                                      callback, e.image, e.title, e.subtitle),
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
