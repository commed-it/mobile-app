
import 'package:flutter/material.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/router.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';

class PageControlRouter extends RouterA {

  @override
  Widget getWidget() {
    return const PageControlWidget();
  }

}

class PageControlWidget extends StatelessWidget {
  const PageControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<PageControlState, PageControlState>(builder: (context, state) {
      var pageController = state.pageController;
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
    }, converter: (store) => store.state);
  }
}
