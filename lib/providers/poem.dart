import 'package:flutter/material.dart';

class Poem with ChangeNotifier {
  final int index;
  final String id;
  final String? title;
  final String? thePoem;

  Poem({
    required this.index,
    required this.id,
    required this.title,
    required this.thePoem,
  });
}
