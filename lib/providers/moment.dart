import 'package:flutter/foundation.dart';

class Moment with ChangeNotifier {
  final String id;
  final String? title;
  final String? imageUrl;
  final String? date;
  final int index;

  Moment({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.index,
  });
}
