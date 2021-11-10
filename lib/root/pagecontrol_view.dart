import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/chat/chat_view.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/formaloffer/formaloffer_view.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/store/actions.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PageControlWidget extends StatelessWidget {
  const PageControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PageControlState>(
        builder: (context, state) {
          return StoreConnector<AppState, Function(int)>(
            converter: (store) =>
                (i) => store.dispatch(MovePageFromPageController(i)),
            builder: (context, callback) {
              return Scaffold(
                appBar: buildAppBar(context),
                body: PageView(
                    controller: state.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: callback,
                    children: const [
                      HomeView(),
                      ChatView(),
                      FormalOffersView(),
                    ]),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.currentPage,
                  fixedColor: appBarColor,
                  onTap: (index) {
                    print("OnTap " + index.toString());
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
              );
            },
          );
        },
        converter: (store) => store.state.pageControlState);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: appBarColor),
      backgroundColor: appBarColor,
      title: Image.asset(
        'assets/logo-white.png',
        fit: BoxFit.cover,
        height: 50,
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: StoreConnector<AppState, VoidCallback>(
              builder: (context, callback) {
                return IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  onPressed: callback,
                );
              },
              converter: (store) => () => store.dispatch(NavigateToNext(Routes.login))),
        ),
      ],
      elevation: 0,
    );
  }
}
