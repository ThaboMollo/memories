import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poems.dart';
import '../screens/new_poem_screen.dart';
import '../widgets/poem_list.dart';

class PoemOverviewScreen extends StatefulWidget {
  static const routeName = '/poem-overview';
  @override
  _PoemOverviewScreenState createState() => _PoemOverviewScreenState();
}

class _PoemOverviewScreenState extends State<PoemOverviewScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Poems>(context).fetchAndSetPoems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blue Roses"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewPoemScreen.routeName,
                );
              },
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PoemList(),
        backgroundColor: Theme.of(context).backgroundColor);
  }
}
