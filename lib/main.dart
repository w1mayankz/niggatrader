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
      ),
      home: const MainNavBar(),
    );
  }
}

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.systemYellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: 'Trading',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ellipsis_circle),
            label: 'More',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(
                  index == 0 ? 'Trading' : index == 1 ? 'Journal' : 'More',
                ),
              ),
              child: Center(
                child: Text(
                  'This is the ${index == 0 ? 'Trading' : index == 1 ? 'Journal' : 'More'} page',
                  style: const TextStyle(color: CupertinoColors.white),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
