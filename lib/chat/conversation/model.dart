import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CommedMessage {
  final bool isOther;

  CommedMessage(this.isOther);

  Widget buildWidget() {
    return const Text("You shouldn't see this");
  }
}

@immutable
class MessageModel implements CommedMessage {
  final bool isOther;
  final String message;

  const MessageModel(this.isOther, this.message);

  @override
  Widget buildWidget() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Text(
        message,
        style: TextStyle(
            color:
                isOther ? theme.primary.textColor : theme.background.textColor),
      ),
    );
  }
}

@immutable
class FormalOfferMessage implements CommedMessage {
  final bool isOther;
  final int version;

  FormalOfferMessage(this.isOther, this.version);

  @override
  Widget buildWidget() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Column(children: [
        Text(
          AppLocalizations.of(ctx)!.formal_offer_version +
              version.toString(),
          style: TextStyle(
              color: isOther
                  ? theme.primary.textColor
                  : theme.background.textColor),
        ),
        Row(
          children: [
            buildButton(theme, AppLocalizations.of(ctx)!.download_pdf,
                Icons.download),
            const SizedBox(
              width: 20,
            ),
            buildButton(
                theme, AppLocalizations.of(ctx)!.sign_pdf, Icons.vpn_key),
          ],
        ),
      ]),
    );
  }

  ElevatedButton buildButton(CommedTheme theme, String message, IconData icon) {
    return ElevatedButton.icon(
      label: Text(
        message,
        style: TextStyle(
            color:
                isOther ? theme.background.textColor : theme.primary.textColor),
      ),
      style: ElevatedButton.styleFrom(
        primary: isOther ? theme.background.color : theme.primary.color,
        onPrimary: theme.accent.color,
      ),
      onPressed: () {},
      icon: Icon(icon,
          color: isOther ? theme.primary.color : theme.background.color),
    );
  }
}
