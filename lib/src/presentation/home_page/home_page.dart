import 'package:flutter/material.dart';
import 'package:movies/src/presentation/home_page/tabs/favourites_tab/favourites_tab.dart';
import 'package:movies/src/presentation/home_page/tabs/movies_tab/movies_tab.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  late final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentTabIndex = index);
        },
        children: [
          MoviesTab(),
          FavouritesTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() => _currentTabIndex = index);
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home_filled)
          ),
          BottomNavigationBarItem(
            label: '',
              icon: Icon(Icons.bookmark)
          ),
        ],
      ),
    );
  }
}
