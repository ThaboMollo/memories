import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/new_moment_screen.dart';
import '../widgets/moments_grid.dart';
import '../providers/moments.dart';

class MomentsOverviewScreen extends StatefulWidget {
  static const routeName = '/overview';
  @override
  _MomentsOverviewScreenState createState() => _MomentsOverviewScreenState();
}

class _MomentsOverviewScreenState extends State<MomentsOverviewScreen> {
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
      Provider.of<Moments>(context).fetchAndSetMoments().then((_) {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Memoriez"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(NewMomentScreen.routeName);
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MomentsGrid(),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
