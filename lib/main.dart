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
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue, // Native iOS Blue
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground, // Critical for the native blur and list contrast
        textTheme: CupertinoTextThemeData(
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
          // FIXED: This kills Roboto on the large scrolling titles
          navLargeTitleTextStyle: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.37,
            color: CupertinoColors.black,
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
  int _currentIndex = 1; // Defaulting to Trades tab for testing

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      // The background blurs automatically when scrollable content passes underneath it
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.activeBlue,
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
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Trades'),
            // Matches the top left Edit text
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Edit'),
              onPressed: () {},
            ),
            // Matches the top right three-dot menu
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_circle),
              onPressed: () {},
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CupertinoListSection.insetGrouped(
                  hasLeading: false,
                  // Generates a minimal long list to prove the blur works
                  children: List.generate(20, (index) {
                    final isNQ = index % 2 == 0;
                    final isWin = index % 3 != 0;
                    
                    return CupertinoListTile.notched(
                      title: Text(isNQ ? 'NQ1!' : 'MNQ1!'),
                      additionalInfo: Text(
                        isWin ? '+\$350.00' : '-\$150.00',
                        style: TextStyle(
                          color: isWin ? CupertinoColors.activeGreen : CupertinoColors.destructiveRed,
                        ),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
