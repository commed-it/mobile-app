import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/chat/conversation/popup.dart';
import 'package:flutter_app/service/dto/message_dto.dart';
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
class MessageModal implements CommedMessage {
  final bool isOther;
  final MessageContentDTO message;

  const MessageModal(this.isOther, this.message);

  @override
  Widget buildWidget() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Text(
        message.message,
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
  final String PDFUrl;
  final String name;
  final int formalOfferId;

  FormalOfferMessage(this.isOther, this.version, this.PDFUrl, this.name, this.formalOfferId);

  @override
  Widget buildWidget() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Column(children: [
        Text(
          this.name,
          style: TextStyle(
            fontSize: 16,
              color: isOther
                  ? theme.primary.textColor
                  : theme.background.textColor, ),
        ),
        SizedBox(height: 10,),
        Text(
          AppLocalizations.of(ctx)!.formal_offer_version + ": " + version.toString(),
          style: TextStyle(
              color: isOther
                  ? theme.primary.textColor
                  : theme.background.textColor),
        ),
        Row(
          children: [
            buildButton(theme, AppLocalizations.of(ctx)!.download_pdf,
                Icons.download, () {}),
            const SizedBox(
              width: 20,
            ),
            buildButton(
                theme, AppLocalizations.of(ctx)!.sign_pdf, Icons.vpn_key, () {
              showDialog(
                  context: ctx,
                  builder: (ctx) => PopUpSign(
                        name: this.name,
                    formalOfferId: this.formalOfferId,
                      ));
            }),
          ],
        ),
      ]),
    );
  }

  ElevatedButton buildButton(CommedTheme theme, String message, IconData icon,
      VoidCallback onPressed) {
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
      onPressed: onPressed,
      icon: Icon(icon,
          color: isOther ? theme.primary.color : theme.background.color),
    );
  }
}
