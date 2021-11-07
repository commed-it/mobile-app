import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/chat/chat_view.dart';
import 'package:flutter_app/formaloffer/formaloffer_view.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/widgets/appbar.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
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
