import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poem.dart';
import '../screens/poem_detail_screen.dart';

class PoemItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PoemDetailScreen.routeName,
          arguments: poem.id,
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(poem.title!),
          ),
        ),
      ),
    );
  }
}
