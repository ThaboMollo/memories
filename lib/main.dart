import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/moments.dart';
import './providers/poems.dart';
import './screens/tabs_screen.dart';
import './screens/moments_overview_screen.dart';
import './screens/moment_detail_screen.dart';
import './screens/new_moment_screen.dart';
import './screens/poem_overview_screen.dart';
import './screens/new_poem_screen.dart';
import './screens/poem_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Moments(),
        ),
        ChangeNotifierProvider.value(
          value: Poems(),
        ),
      ],
      child: MaterialApp(
        title: "The Teddyz",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.blueAccent,
          backgroundColor: Colors.cyanAccent[100],
        ),
        home: TabsScreen(),
        routes: {
          MomentDetailScreen.routeName: (ctx) => MomentDetailScreen(),
          NewMomentScreen.routeName: (ctx) => NewMomentScreen(),
          PoemOverviewScreen.routeName: (ctx) => PoemOverviewScreen(),
          NewPoemScreen.routeName: (ctx) => NewPoemScreen(),
          MomentsOverviewScreen.routeName: (ctx) => MomentsOverviewScreen(),
          PoemDetailScreen.routeName: (ctx) => PoemDetailScreen(),
        },
      ),
    );
  }
}
