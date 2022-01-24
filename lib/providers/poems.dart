import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './poem.dart';

class Poems with ChangeNotifier {
  List<Poem> _poemItem = [
    //  Poem(
    //   id: "i1",
    //   title: "Day od Operation",
    //   thePoem: "The Celestial's day",
    //   index: 0,
    // ),
    // Poem(
    //   id: "i2",
    //   title: "Proverbs 31 woman",
    //   thePoem: "The Celestial's day",
    //   index: 1,
    // ),
  ];

  List<Poem> get poemItem {
    return [..._poemItem];
  }

  Poem findById(String id) {
    return _poemItem.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetPoems() async {
    const url = 'https://memories-5e194.firebaseio.com/poems.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Poem> loadedPoems = [];
      extractedData.forEach((poemId, poemValue) {
        loadedPoems.add(Poem(
          index: poemValue['index'],
          id: poemId,
          title: poemValue['title'],
          thePoem: poemValue['thePoem'],
        ));
      });
      _poemItem = loadedPoems;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addPoem(Poem poem) async {
    const url = 'https://memories-5e194.firebaseio.com/poems.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'index': _poemItem.length,
          'id': poem.id,
          'title': poem.title,
          'thePoem': poem.thePoem,
        }),
      );
      final newPoem = Poem(
        index: _poemItem.length,
        id: json.decode(response.body)['name'],
        title: poem.title,
        thePoem: poem.thePoem,
      );
      _poemItem.add(newPoem);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updatePoem(String id, Poem newMoment) async {
    final mIndex = _poemItem.indexWhere((element) => element.id == id);
    if (mIndex >= 0) {
      final url = 'https://memories-5e194.firebaseio.com/moments/$id.json';
      await http.patch(
        Uri.parse(url),
        body: json.encode({
          'index': newMoment.index,
          'id': newMoment.id,
          'title': newMoment.title,
          'thePoem': newMoment.thePoem,
        }),
      );
      _poemItem[mIndex] = newMoment;
      notifyListeners();
    } else {
      print('... ya gana');
    }
  }
}
