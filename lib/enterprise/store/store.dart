import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState enterpriseReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case NavigateToEnterpriseDetail:
      action = action as NavigateToEnterpriseDetail;
      Enterprise enterprise = Enterprise("La Bicicleta", "El restaurante ocupa la planta baja del Casal organizado en dos comedores: El comedor Do Carrasca, con cabida para treinta comensales, nos ofrece posada al abrigo de su gran chimenea. El comedor Da Paloma está pensado para albergar pequeñas celebraciones o comidas de empresa, con una capacidad de hasta ochenta personas. Además dispone de proyector y pantalla lo que posibilita su utilización para presentaciones y eventos similares. El local, inaugurado en el verano de 2004, ofrece cocina tradicional con toques de modernidad. El restaurante aprovecha los productos de la zona ( excelentes carnes, salazones, pulpo, productos de la huerta, pescados de la cercana ría de Vigo…) combinándolos con nuevos sabores y texturas.", "78099079A", "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Flogo-semplice-della-tagliatella-piano-marchio-130436365.jpg&f=1&nofb=1", "+34 625485223");
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(Routes.enterprise);
      return prev.copy(enterpriseDetail: enterprise, navigatorKey: navKey);
    default:
      return prev;
  }
}
