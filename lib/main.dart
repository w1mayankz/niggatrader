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
          // Kills Roboto on main text
          textStyle: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 17.0,
            letterSpacing: -0.41,
          ),
          // Kills Roboto on top navbar buttons (like the "Add" text)
          navActionTextStyle: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 17.0,
            color: CupertinoColors.activeBlue,
            letterSpacing: -0.41,
          ),
          // Kills Roboto on popups and dropdowns
          actionTextStyle: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 17.0,
            color: CupertinoColors.activeBlue,
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
              // Font size and SF Pro are now automatically inherited from navActionTextStyle
              child: const Text('Add'),
              onPressed: () {},
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_circle, size: 28.0),
              onPressed: () {
                // The Tap-to-Open Dropdown Trick
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return Align(
                      // Positions the menu in the top right, exactly under the icon
                      alignment: const Alignment(0.9, -0.72),
                      child: SizedBox(
                        width: 220,
                        // Wraps the native inset list so it acts as a floating dropdown
                        child: CupertinoListSection.insetGrouped(
                          margin: EdgeInsets.zero,
                          children: [
                            CupertinoListTile.notched(
                              title: const Text('Sort Logs'),
                              trailing: const Icon(CupertinoIcons.sort_down, color: CupertinoColors.activeBlue),
                              onTap: () => Navigator.pop(context),
                            ),
                            CupertinoListTile.notched(
                              title: const Text('Copy Data'),
                              trailing: const Icon(CupertinoIcons.doc_on_clipboard, color: CupertinoColors.activeBlue),
                              onTap: () => Navigator.pop(context),
                            ),
                            CupertinoListTile.notched(
                              title: const Text('Share'),
                              trailing: const Icon(CupertinoIcons.share, color: CupertinoColors.activeBlue),
                              onTap: () => Navigator.pop(context),
                            ),
                            CupertinoListTile.notched(
                              title: const Text('Delete All', style: TextStyle(color: CupertinoColors.destructiveRed)),
                              trailing: const Icon(CupertinoIcons.delete, color: CupertinoColors.destructiveRed),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CupertinoListSection.insetGrouped(
                  header: const Text(
                    'SEP 7, 2026',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  children: List.generate(10, (index) {
                    final isWin = index % 3 != 0;
                    return ExpandableTradeRow(isWin: isWin);
                  }),
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text(
                    'SEP 4, 2026',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  children: List.generate(15, (index) {
                    final isWin = index % 2 == 0;
                    return ExpandableTradeRow(isWin: isWin);
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

class ExpandableTradeRow extends StatefulWidget {
  final bool isWin;
  
  const ExpandableTradeRow({super.key, required this.isWin});

  @override
  State<ExpandableTradeRow> createState() => _ExpandableTradeRowState();
}

class _ExpandableTradeRowState extends State<ExpandableTradeRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoListTile.notched(
          title: const Text('NQ1!'),
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
          additionalInfo: Text(
            widget.isWin ? '+\$350.00' : '-\$150.00',
            style: TextStyle(
              color: widget.isWin ? CupertinoColors.activeGreen : CupertinoColors.destructiveRed,
            ),
          ),
          trailing: Icon(
            _isExpanded ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right,
            color: CupertinoColors.systemGrey3,
            size: 18.0,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Container(
            width: double.infinity,
            color: CupertinoColors.secondarySystemGroupedBackground,
            padding: const EdgeInsets.only(left: 60.0, right: 16.0, top: 8.0, bottom: 12.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setup: Continuation',
                  style: TextStyle(fontSize: 14.0, color: CupertinoColors.secondaryLabel),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Time: 09:30 AM EST',
                  style: TextStyle(fontSize: 14.0, color: CupertinoColors.secondaryLabel),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
