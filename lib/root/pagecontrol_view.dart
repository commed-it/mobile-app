import 'package:flutter/material.dart';
import 'package:flutter_app/chat/chat_view.dart';
import 'package:flutter_app/formaloffer/formaloffer_view.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/store/actions.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants.dart';

class PageControlWidget extends StatelessWidget {
  const PageControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<PageControlState, PageControlState>(
        builder: (context, state) {
          var pageController = state.pageController;
          return
            StoreConnector<PageControlState, Function(dynamic)>(
                converter: (store) => (i) => () =>
                    store.dispatch(MovePageFromPageController(i)),
                builder: (context, callback) {
                  return Scaffold(
                    appBar: appBarFactory(context),
                    body:
                    PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          callback(index);
                        },
                        children: [
                          HomeView(),
                          ChatView(),
                          FormalOffersView(),
                        ]),
                    bottomNavigationBar: StoreConnector<PageControlState, int>(builder : (context, currentPage) {
                      return BottomNavigationBar(
                        currentIndex: currentPage,
                        fixedColor: appBarColor,
                        onTap: (index) {
                          callback(index);
                          pageController.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                        },
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home_outlined), label: 'Home'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.chat_outlined), label: 'Chat'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.app_registration),
                              label: 'Formal Offers')
                        ],
                      );
                    },
                    converter : (store) => store.state.currentPage),
                  );
                });

        }, converter: (store) => store.state);
  }
}