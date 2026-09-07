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
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
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
  int _currentIndex = 1; 

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
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
                child: Text('This is the ${titles[index]} page'),
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
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              // Forced native 17.0 size for top bar text actions
              child: const Text('Add', style: TextStyle(fontSize: 17.0)),
              onPressed: () {},
            ),
            trailing: CupertinoContextMenu(
              // Long-press the icon to trigger the native translucent pop-out menu
              actions: <Widget>[
                CupertinoContextMenuAction(
                  trailingIcon: CupertinoIcons.sort_down,
                  child: const Text('Sort Logs'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoContextMenuAction(
                  trailingIcon: CupertinoIcons.doc_on_clipboard,
                  child: const Text('Copy Data'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoContextMenuAction(
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('Share'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.delete,
                  child: const Text('Delete All'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              // Forced native 28.0 size for top bar icons
              child: const Icon(CupertinoIcons.ellipsis_circle, size: 28.0, color: CupertinoColors.activeBlue),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Group 1
                CupertinoListSection.insetGrouped(
                  header: const Text('SEP 7, 2026'),
                  children: [
                    CupertinoListTile.notched(
                      title: const Text('NQ1!'),
                      subtitle: const Text('Continuation • Long'),
                      // Matches the exact rounded square dimension of iOS list icons
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          'assets/nq.png',
                          width: 28.0,
                          height: 28.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 28.0, 
                            height: 28.0, 
                            color: CupertinoColors.systemGrey4
                          ),
                        ),
                      ),
                      additionalInfo: const Text(
                        '+\$350.00',
                        style: TextStyle(color: CupertinoColors.activeGreen),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      title: const Text('MNQ1!'),
                      subtitle: const Text('Continuation • Short'),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          'assets/nq.png',
                          width: 28.0,
                          height: 28.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 28.0, 
                            height: 28.0, 
                            color: CupertinoColors.systemGrey4
                          ),
                        ),
                      ),
                      additionalInfo: const Text(
                        '-\$50.00',
                        style: TextStyle(color: CupertinoColors.destructiveRed),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                  ],
                ),
                // Group 2
                CupertinoListSection.insetGrouped(
                  header: const Text('SEP 4, 2026'),
                  children: [
                    CupertinoListTile.notched(
                      title: const Text('NQ1!'),
                      subtitle: const Text('Continuation • Long'),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          'assets/nq.png',
                          width: 28.0,
                          height: 28.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 28.0, 
                            height: 28.0, 
                            color: CupertinoColors.systemGrey4
                          ),
                        ),
                      ),
                      additionalInfo: const Text(
                        '+\$1,200.00',
                        style: TextStyle(color: CupertinoColors.activeGreen),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
