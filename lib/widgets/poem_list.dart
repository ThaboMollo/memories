import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poems.dart';
import '../widgets/poem_item.dart';

class PoemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final poemData = Provider.of<Poems>(context);
    final poems = poemData.poemItem;
    return ListView.builder(
      itemCount: poems.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: poems[i],
        child: PoemItem(),
      ),
    );
  }
}
