import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/chat/listchat_view.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/profile_view.dart';
import 'package:flutter_app/formaloffer/formaloffer_view.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/store/actions.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/appbar.dart';
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
                  appBar: buildAppBarLogged(context, theme),
                  body: PageView(
                      controller: state.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: callback,
                      children: [
                        HomeView(),
                        ChatView(),
                        FormalOffersView(),
                        StoreConnector<AppState, Enterprise>(
                            converter: (sto) => sto.state.myEnterpriseDetail,
                            builder: (ctx, enterprise) =>
                                buildProfileView(theme, enterprise)),
                      ]),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.currentPage,
                    fixedColor: theme.appBarColor,
                    unselectedItemColor: theme.unselectedLabel,
                    showUnselectedLabels: true,
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
                          label: 'Formal Offers'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.account_circle), label: 'Profile'),
                    ],
                  ),
                ),
                converter: (s) => s.state.theme,
              ),
            ),
        converter: (store) => store.state.pageControlState);
  }
}
