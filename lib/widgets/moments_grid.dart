import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/moments.dart';
import './moment_item.dart';

class MomentsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final momentsData = Provider.of<Moments>(context);
    final moments = momentsData.momentItem;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: moments.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: moments[i],
        child: MomentItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
