import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './moment.dart';

class Moments with ChangeNotifier {
  List<Moment> _momentItem = [];

  List<Moment> get momentItem {
    return [..._momentItem];
  }

  Moment findById(String id) {
    return _momentItem.firstWhere((element) => element.id == id);
  }

  Moment findNext(int index) {
    if (index == _momentItem.length - 1) {
      return _momentItem.elementAt(index);
    }
    return _momentItem.elementAt(index + 1);
  }

  Moment findPrev(int index) {
    if (index == 0) {
      return _momentItem.elementAt(index);
    }
    return _momentItem.elementAt(index - 1);
  }

  Future<void> fetchAndSetMoments() async {
    const url = 'https://memories-5e194.firebaseio.com/moments.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Moment> loadedMoments = [];
      extractedData.forEach((momentId, momentData) {
        loadedMoments.add(Moment(
          index: momentData['index'],
          id: momentId,
          title: momentData['title'],
          imageUrl: momentData['imageUrl'],
          date: momentData['date'],
        ));
      });
      _momentItem = loadedMoments;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addMoment(Moment moment) async {
    const url = 'https://memories-5e194.firebaseio.com/moments.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'index': _momentItem.length,
          'title': moment.title,
          'imageUrl': moment.imageUrl,
          'date': moment.date,
        }),
      );
      final newMoment = Moment(
        index: _momentItem.length,
        title: moment.title,
        imageUrl: moment.imageUrl,
        date: moment.date,
        id: json.decode(response.body)['name'],
      );
      _momentItem.add(newMoment);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateMoment(String id, Moment newMoment) async {
    final mIndex = _momentItem.indexWhere((element) => element.id == id);
    if (mIndex >= 0) {
      final url = 'https://memories-5e194.firebaseio.com/moments/$id.json';
      await http.patch(
        Uri.parse(url),
        body: json.encode({
          'index': newMoment.index,
          'title': newMoment.title,
          'imageUrl': newMoment.imageUrl,
          'date': newMoment.date,
        }),
      );
      _momentItem[mIndex] = newMoment;
      notifyListeners();
    } else {
      print('... ya gana');
    }
  }

  Future<void> deleteMoment(String id) async {
    final url = 'https://memories-5e194.firebaseio.com/moments/$id.json';
    final existingMomentIndex =
        _momentItem.indexWhere((element) => element.id == id);
    Moment? existingMoment = _momentItem[existingMomentIndex];
    _momentItem.removeAt(existingMomentIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _momentItem.insert(existingMomentIndex, existingMoment);
      notifyListeners();
      throw const HttpException("Unable to delete.");
    }
    existingMoment = null;
  }
}
