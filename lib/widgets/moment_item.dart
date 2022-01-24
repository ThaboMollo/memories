import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/moment.dart';
import '../screens/moment_detail_screen.dart';

class MomentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moment = Provider.of<Moment>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MomentDetailScreen.routeName,
              arguments: moment.id,
            );
          },
          child: Image.network(
            moment.imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            moment.title!,
          ),
        ),
      ),
    );
  }
}
