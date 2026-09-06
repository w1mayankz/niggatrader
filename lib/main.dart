import 'package:flutter/cupertino.dart';

void main() {
  runApp(const TradingJournalApp());
}

class TradingJournalApp extends StatelessWidget {
  const TradingJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Trading Journal',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemYellow,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 17.0,
            letterSpacing: -0.41,
          ),
          navTitleTextStyle: TextStyle(
            fontFamily: '.SF Pro Display',
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
          ),
        ),
      ),
      home: const MainNavBar(),
    );
  }
}

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.systemYellow,
        inactiveColor: CupertinoColors.systemGrey,
        iconSize: 26.0, // Shrunk from 30.0 to match native iOS proportions
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? CupertinoIcons.square_grid_2x2_fill : CupertinoIcons.square_grid_2x2),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 1 ? CupertinoIcons.chart_bar_alt_fill : CupertinoIcons.chart_bar_alt), // Fixed matching pair
            label: 'Trades',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 2 ? CupertinoIcons.chart_pie_fill : CupertinoIcons.chart_pie),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3 ? CupertinoIcons.ellipsis_circle_fill : CupertinoIcons.ellipsis_circle),
            label: 'More',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        // Updated to 4 tabs
        final titles = ['Dashboard', 'Trades', 'Analytics', 'More'];
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(titles[index]),
          ),
          child: Center(
            child: Text(
              'This is the ${titles[index]} page',
              style: const TextStyle(color: CupertinoColors.white),
            ),
          ),
        );
      },
    );
  }
}
