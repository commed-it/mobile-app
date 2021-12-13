import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_app/widgets/list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/enterprise.dart';

class EnterpriseView extends StatelessWidget {
  const EnterpriseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (ctx, theme) => StoreConnector<AppState, Enterprise>(
        converter: (sto) => sto.state.enterpriseDetail,
        builder: (ctx, enterprise) => StoreConnector<AppState, bool>(
          converter: (sto) => sto.state.loggedState == LoggedState.Logged,
          builder: (ctx, isLogged) => Scaffold(
            backgroundColor: theme.appBarColor,
            appBar: isLogged
                ? buildAppBarLogged(context, theme)
                : buildNotloggedAppBar(context, theme),
            body: Container(
              child: buildProfileView(theme, enterprise),
            ),
          ),
        ),
      ),
    );
  }
}

Padding body(CommedTheme theme, Enterprise enterprise, yPadding) {
  return Padding(
    padding: EdgeInsets.only(top: yPadding + 40.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CenterLogoEnterprise(theme, enterprise),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardEnterpriseInformation(theme: theme, enterprise: enterprise),
                DescriptionContainer(theme: theme, enterprise: enterprise),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget bacgroundBody(CommedTheme theme, yPadding) {
  return Padding(
    padding: EdgeInsets.only(top: yPadding + 120.0),
    child: Container(
      color: theme.primary.textColor,
    ),
  );
}

Container header(CommedTheme theme, Enterprise enterprise) {
  return Container(
    color: theme.primary.color,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
      child: Column(
        children: [
          Text(
            enterprise.name,
            style: TextStyle(color: theme.primary.textColor, fontSize: 30),
          ),
        ],
      ),
    ),
  );
}

Widget buildProfileView(CommedTheme theme, Enterprise enterprise) {
  const double yPadding = 20;
  return Stack(
    fit: StackFit.expand,
    children: [
      header(theme, enterprise),
      bacgroundBody(theme, yPadding),
      body(theme, enterprise, yPadding),
    ],
  );
}

class DescriptionContainer extends StatelessWidget {
  final CommedTheme theme;
  final Enterprise enterprise;

  const DescriptionContainer(
      {Key? key, required this.theme, required this.enterprise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.description,
              style: TextStyle(
                fontSize: 30,
              )),
          Divider(
            endIndent: 180,
            color: theme.background.textColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(enterprise.description,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.justify,
                softWrap: true,
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class CardEnterpriseInformation extends StatelessWidget {
  const CardEnterpriseInformation({
    Key? key,
    required this.theme,
    required this.enterprise,
  }) : super(key: key);

  final CommedTheme theme;
  final Enterprise enterprise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: theme.primary.color,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              RowListItem(
                  title: AppLocalizations.of(context)!.nif,
                  subtitle: enterprise.nif,
                  iconData: Icons.article_outlined),
              RowListItem(
                  title: AppLocalizations.of(context)!.contact,
                  subtitle: enterprise.contactInfo,
                  iconData: Icons.local_phone),
            ],
          ),
        ),
      ),
    );
  }
}

class RowListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const RowListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 40,
      ),
      title: title,
      titleColor: Colors.white,
      describe: subtitle,
      describeColor: Colors.white,
      onPressed: () {},
    );
  }
}

class CardInformation extends StatelessWidget {
  final CommedTheme theme;
  final String cardTitle;
  final String cardBody;
  final Icon icon;

  const CardInformation(
    CommedTheme theme,
    Icon icon,
    String cardTitle,
    String cardBody, {
    Key? key,
  })  : theme = theme,
        icon = icon,
        cardTitle = cardTitle,
        cardBody = cardBody,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      child: SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: [
                    icon,
                    SizedBox(width: 7),
                    Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Market',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cardBody,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Market',
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class CenterLogoEnterprise extends StatelessWidget {
  final CommedTheme theme;
  final Enterprise enterprise;

  const CenterLogoEnterprise(
    CommedTheme theme,
    Enterprise enterprise, {
    Key? key,
  })  : theme = theme,
        enterprise = enterprise,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: theme.primary.textColor,
                maxRadius: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(enterprise.urlLogo),
                  maxRadius: 80,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
