import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/chat/listchat_view.dart';
import 'package:flutter_app/formaloffer/formaloffer_view.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/store/actions.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PageControlWidget extends StatelessWidget {
  const PageControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PageControlState>(
        builder: (context, state) => StoreConnector<AppState, Function(int)>(
              converter: (store) =>
                  (i) => store.dispatch(MovePageFromPageController(i)),
              builder: (context, callback) =>
                  StoreConnector<AppState, CommedTheme>(
                builder: (ctx, theme) => Scaffold(
                  appBar: buildAppBar(context, theme),
                  body: PageView(
                      controller: state.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: callback,
                      children: [
                        HomeView(),
                        ChatView(),
                        FormalOffersView(),
                      ]),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.currentPage,
                    fixedColor: theme.appBarColor,
                    onTap: (index) {
                      callback(index);
                      state.pageController.animateToPage(index,
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
                  ),
                ),
                converter: (s) => s.state.theme,
              ),
            ),
        converter: (store) => store.state.pageControlState);
  }
}

AppBar buildAppBar(BuildContext context, CommedTheme theme) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: theme.appBarColor),
    backgroundColor: theme.appBarColor,
    title: Image.asset(
      'assets/logo-white.png',
      fit: BoxFit.cover,
      height: 50,
    ),
    actions: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: StoreConnector<AppState, VoidCallback>(
          converter: (store) =>
              () => store.dispatch(const NavigateToNext(Routes.searcher)),
            builder: (ctx, callback) => IconButton(
              icon: Icon(Icons.search, color: theme.primary.textColor),
              onPressed: callback,
            ),
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StoreConnector<AppState, VoidCallback>(
            builder: (context, callback) {
              return IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: theme.primary.textColor,
                ),
                onPressed: callback,
              );
            },
            converter: (store) =>
                () => store.dispatch(const NavigateToNext(Routes.login))),
      ),
    ],
    elevation: 0,
  );
}
