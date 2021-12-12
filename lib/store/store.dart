import 'package:flutter/material.dart';
import 'package:flutter_app/auth/store.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/store.dart';
import 'package:flutter_app/generic/carrousel/exported.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/product/store/store.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/searcher/model.dart';
import 'package:flutter_app/store/theme.dart';

import 'actions.dart';

List<String> bicicletaImageList = [
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/255858093_469135257869381_6653683263538409749_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=83KlgONymIoAX_-hMc-&edm=AABBvjUBAAAA&ccb=7-4&oh=ecec01dccc7118a2e65013db041ed9a0&oe=619BFB74&_nc_sid=83d603",
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/222854503_991402534928079_1208240465553245294_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=103&_nc_ohc=iw8vN24ekIsAX8UQtGH&edm=AP_V10EBAAAA&ccb=7-4&oh=b47484986a47883da10a1a6886d228bb&oe=619C0C3F&_nc_sid=4f375e",
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/225119727_249351956766946_5572182716211699871_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=oCtxhiayOC8AX_hzbUH&edm=AP_V10EBAAAA&ccb=7-4&oh=ffdf872d80464cf00aad15fd0df8ddb0&oe=619B1799&_nc_sid=4f375e",
];
List<String> rodiImageList = [
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmontserratcentre.com%2Fwp-content%2Fuploads%2F2015%2F11%2FRODI-MOTOR-3.jpg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Foriolcastello.com%2Fwp-content%2Fuploads%2F2019%2F05%2FZ6A1293.jpg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.lavanguardia.com%2Ffiles%2Fog_thumbnail%2Fuploads%2F2018%2F02%2F02%2F5f1602a78773c.jpeg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2F736x%2F3f%2F49%2Fa0%2F3f49a04ac8a6d48daa164afe3393a736.jpg&f=1&nofb=1"
];

typedef AppStateFunction = AppState Function(AppState state);

@immutable
class LambdaAction extends AppAction {
  final AppStateFunction func;

  const LambdaAction(this.func);
}

enum LoggedState {
  NotLogged,
  Logged,
  CouldntLog,
}

@immutable
class AppState {
  final LoginState loginViewState;
  final PageControlState pageControlState;
  final GlobalKey<NavigatorState> navigatorKey;
  final List<Product> products;
  final CommedTheme theme;
  final Enterprise enterpriseDetail;
  final Searcher searcher;
  final LoggedState loggedState;

  // add User, ...
  AppState(
      this.loginViewState,
      this.pageControlState,
      this.navigatorKey,
      this.products,
      this.theme,
      this.enterpriseDetail,
      this.searcher,
      this.loggedState);

  // add User, ...

  AppState.init()
      : loginViewState = const LoginState.init(),
        pageControlState = PageControlState.init(),
        navigatorKey = GlobalKey<NavigatorState>(),
        products = [
          ProductContent(
              ImageContainer(bicicletaImageList),
              "Comida para llevar",
              "El restaurante ocupa la planta baja del Casal organizado en dos comedores: El comedor Do Carrasca, con cabida para treinta comensales, nos ofrece posada al abrigo de su gran chimenea. El comedor Da Paloma está pensado para albergar pequeñas celebraciones o comidas de empresa, con una capacidad de hasta ochenta personas. Además dispone de proyector y pantalla lo que posibilita su utilización para presentaciones y eventos similares. El local, inaugurado en el verano de 2004, ofrece cocina tradicional con toques de modernidad. El restaurante aprovecha los productos de la zona ( excelentes carnes, salazones, pulpo, productos de la huerta, pescados de la cercana ría de Vigo…) combinándolos con nuevos sabores y texturas.",
              false,
              CompanySmallDetail(
                  "https://instagram.fbcn5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/25024378_169126683844186_21293180838215680_n.jpg?_nc_ht=instagram.fbcn5-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=jVg3B7QJJo0AX9zxkms&edm=ABfd0MgBAAAA&ccb=7-4&oh=4731660aa270050f2805bb12fd3a2a97&oe=6196859C&_nc_sid=7bff83",
                  "La Bicicleta")),
          ProductContent(
              ImageContainer(rodiImageList),
              "Revisiones de Motores",
              """Nuestra cadena de centros de mecánica integral del automóvil RODI nació en 1990. Somos fruto del acuerdo de colaboración de dos empresas leridanas de la automoción con más de 50 años de experiencia en el sector, Neumáticos Segur y Serveis Germans Esteve, a través de la sociedad Lleidatana del Pneumàtic. Nuestro crecimiento ha sido una constante, convirtiéndonos en poco tiempo en la cadena líder en puntos de distribución y servicios de mecánica integral del automóvil en Cataluña, Aragón y Galicia, además de en las Islas Canarias, gracias a la adquisición de la cadena El Paso 2000.

              A finales de 2013, tras 20 años, rediseñamos la marca y la estrategia de negocio pasando a denominarnos RODI MOTOR SERVICES.

          Esta renovación responde a la nueva y firme apuesta por evolucionar y mejorar para dar respuesta a las nuevas necesidades de nuestros clientes con la incorporación de servicios de mecánica integral del automóvil. Sin embargo, esta renovación mantiene intactos los objetivos y el espíritu que nos han caracterizado y la trayectoria de la empresa en estas últimas décadas: el servicio integral al cliente, la proximidad y la accesibilidad. En definitiva, la satisfacción del cliente.""",
              false,
              CompanySmallDetail(
                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fofertes.ccoo.cat%2Fwp-content%2Fuploads%2Fsites%2F131%2F2019%2F05%2FRodi_Motor_Services_logo.jpg&f=1&nofb=1",
                  "Rodi")),
        ]
            .asMap()
            .map((index, value) => MapEntry(index, Product(index, value)))
            .values
            .toList(),
        theme = CommedTheme.init(),
        enterpriseDetail = const Enterprise.init(),
        searcher = Searcher.init(),
        loggedState = LoggedState.NotLogged;

  AppState copy(
          {LoginState? loginViewState,
          PageControlState? pageControlState,
          GlobalKey<NavigatorState>? navigatorKey,
          List<Product>? products,
          CommedTheme? theme,
          Enterprise? enterpriseDetail,
          Searcher? searcher,
          LoggedState? loggedState}) =>
      AppState(
          loginViewState ?? this.loginViewState,
          pageControlState ?? this.pageControlState,
          navigatorKey ?? this.navigatorKey,
          products ?? this.products,
          theme ?? this.theme,
          enterpriseDetail ?? this.enterpriseDetail,
          searcher ?? this.searcher,
          loggedState ?? this.loggedState);
}

AppState navigationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case NavigateToNext:
      var newAction = action as NavigateToNext;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(newAction.destinationRoute);
      return prev.copy(navigatorKey: navKey);
    case NavigateToNextAndReplace:
      var newAction = action as NavigateToNextAndReplace;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushReplacementNamed(newAction.destinationRoute);
      return prev.copy(navigatorKey: navKey);
    case NavigateBack:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey..currentState!.pop();
      return prev.copy(navigatorKey: navKey);
    case LambdaAction:
      return (action as LambdaAction).func(prev);
  }
  return prev;
}

AppState appReducer(AppState prev, AppAction action) {
  prev = navigationReducer(prev, action);
  prev = authenticationReducer(prev, action);
  prev = globalLoginReducer(prev, action);
  prev = globalPageControlReducer(prev, action);
  prev = listProductsReducer(prev, action);
  prev = enterpriseReducer(prev, action);
  prev = searcherReducer(prev, action);
  return prev;
}
