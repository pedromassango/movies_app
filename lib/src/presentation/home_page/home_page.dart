import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/movies/favorite_movies/favorite_movies_cubit.dart';
import 'package:movies/src/application/movies/movies_cubit.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/presentation/home_page/tabs/movies_tab/movies_tab.dart';

import 'tabs/favorites_tab/favorites_tab.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  late final PageController _pageController = PageController();

  MoviesRepository getMoviesRepository() {
    return getIt.get<MoviesRepository>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22272e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Movies', style: TextStyle(
          fontSize: 32,
        ),),
        actions: [
          IconButton(icon: Icon(Icons.search_sharp), onPressed: () {})
        ],
      ),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MoviesCubit(moviesRepository: getMoviesRepository()),),
            BlocProvider(create: (_) => FavoriteMoviesCubit(moviesRepository: getMoviesRepository()),),
          ],
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentTabIndex = index);
            },
            children: [
              MoviesTab(),
              FavoritesTab(),
            ],
          ),
        ),
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
