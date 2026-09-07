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
          // NO DOTS: Forces Flutter to use the downloaded .otf files
          textStyle: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 17.0,
            letterSpacing: -0.41,
          ),
          navTitleTextStyle: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
          ),
          tabLabelTextStyle: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
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
        iconSize: 26.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            activeIcon: Icon(CupertinoIcons.chart_bar_fill),
            label: 'Trades',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_pie),
            activeIcon: Icon(CupertinoIcons.chart_pie_fill),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ellipsis_circle),
            activeIcon: Icon(CupertinoIcons.ellipsis_circle_fill),
            label: 'More',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            // Replaces the generic text page with our custom Trades tab
            if (index == 1) {
              return const TradesTab();
            }
            
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
      },
    );
  }
}

class TradesTab extends StatelessWidget {
  const TradesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Trades'),
          ),
          SliverFillRemaining(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CupertinoListSection.insetGrouped(
                  header: const Text('RECENT SETUPS'),
                  children: [
                    CupertinoListTile.notched(
                      title: const Text('US30 Continuation'),
                      subtitle: const Text('Long • Entry: 38,450.00'),
                      additionalInfo: const Text('+ \$450', style: TextStyle(color: CupertinoColors.activeGreen)),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      title: const Text('US30 Continuation'),
                      subtitle: const Text('Short • Entry: 38,600.00'),
                      additionalInfo: const Text('- \$120', style: TextStyle(color: CupertinoColors.destructiveRed)),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text('QUICK ACTIONS'),
                  children: [
                    CupertinoListTile.notched(
                      title: const Text('Log New Trade'),
                      leading: const Icon(CupertinoIcons.add_circled_solid, color: CupertinoColors.systemYellow),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
