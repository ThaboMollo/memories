import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poems.dart';

class PoemDetailScreen extends StatelessWidget {
  static const routeName = '/poem-detail';

  @override
  Widget build(BuildContext context) {
    final poemId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedPoem =
        Provider.of<Poems>(context, listen: false).findById(poemId);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedPoem.title!),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              // Colors.cyanAccent,
              // Colors.orangeAccent,
              Colors.red,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                loadedPoem.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  loadedPoem.thePoem!,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
