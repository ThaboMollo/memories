import 'package:flutter/material.dart';

import './moments_overview_screen.dart';
import './poem_overview_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Blue Roses"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.image),
                  text: "Memories",
                ),
                Tab(
                  icon: Icon(Icons.edit),
                  text: "Blue Roses",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MomentsOverviewScreen(),
              PoemOverviewScreen(),
            ],
          )),
    );
  }
}
