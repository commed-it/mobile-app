import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState enterpriseReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case ChangeEnterpriseDetail:
      action = action as ChangeEnterpriseDetail;
      print(prev.enterpriseDetail);
      Enterprise enterprise = Enterprise("La Bicicleta", "El restaurante ocupa la planta baja del Casal organizado en dos comedores: El comedor Do Carrasca, con cabida para treinta comensales, nos ofrece posada al abrigo de su gran chimenea. El comedor Da Paloma está pensado para albergar pequeñas celebraciones o comidas de empresa, con una capacidad de hasta ochenta personas. Además dispone de proyector y pantalla lo que posibilita su utilización para presentaciones y eventos similares. El local, inaugurado en el verano de 2004, ofrece cocina tradicional con toques de modernidad. El restaurante aprovecha los productos de la zona ( excelentes carnes, salazones, pulpo, productos de la huerta, pescados de la cercana ría de Vigo…) combinándolos con nuevos sabores y texturas.", "78099079A", "https://instagram.fbcn5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/25024378_169126683844186_21293180838215680_n.jpg?_nc_ht=instagram.fbcn5-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=jVg3B7QJJo0AX9zxkms&edm=ABfd0MgBAAAA&ccb=7-4&oh=4731660aa270050f2805bb12fd3a2a97&oe=6196859C&_nc_sid=7bff83", "+34 625485223");
      print(enterprise);
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(Routes.enterprise);
      return prev.copy(enterpriseDetail: enterprise, navigatorKey: navKey);
    default:
      return prev;
  }
}
