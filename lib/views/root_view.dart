import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/store/router.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/views/chat_view.dart';
import 'package:flutter_app/views/formaloffer_view.dart';
import 'package:flutter_app/views/home_view.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

class RootWidget extends StatelessWidget {
  final store = Store((x, a) => x, initialState: AppState.init());
  RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store, child: _RouterWidget)
    // TODO: implement build
    throw UnimplementedError();
  }

}

class _RouterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RouterA>(builder: (context, router) {
      return router.getWidget();
    }, converter: (store) => store.state.router);
  }
}

class _NavigationViewState extends State<RootWidget> {
  int currrentPage = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFactory(context),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            currrentPage = index;
            setState(() {});
          },
          children: const [
            HomeView(),
            ChatView(),
            FormalOffersView(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currrentPage,
        fixedColor: appBarColor,
        onTap: (index) {
          currrentPage = index;
          pageController.animateToPage(currrentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: 'Formal Offers')
        ],
      ),
    );
  }
}
