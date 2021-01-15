import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'database.dart';
import 'loved.dart';
import 'settings.dart';
import 'values.dart';

/// The main application screen
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  Map<int, Widget> get pages => {
        0: Values(),
        1: Loved(),
        2: Database(),
        3: Settings(),
      };

  List<BottomNavigationBarItem> get bottomNavigationBarItems => [
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.commentQuote),
          label: 'Values',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Loved',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.harddisk),
          label: 'Database',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: pages[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
