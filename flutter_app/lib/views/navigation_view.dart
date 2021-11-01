import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants.dart';

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
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: appBarColor),
        backgroundColor: appBarColor,
        title: const Text('Commed'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
      ),
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

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor, child: const Center(child: Text("Home")));
  }
}

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor, child: const Center(child: Text("Chat")));
  }
}

class FormalOffersView extends StatelessWidget {
  const FormalOffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: const Center(child: Text("Formal Offers")));
  }
}
