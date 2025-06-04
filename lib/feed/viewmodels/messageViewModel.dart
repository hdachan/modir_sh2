import 'package:flutter/cupertino.dart';

import '../sevices/supabase_service.dart';

class Test1ViewModel with ChangeNotifier {
  final SupabaseService _service;
  List<String> _welcomeItems = [];
  List<String> _categoryItems = [];
  static const int maxWelcome = 3;
  static const int maxCategory = 5;

  List<String> get welcomeItems => _welcomeItems;
  List<String> get categoryItems => _categoryItems;

  Test1ViewModel(this._service);

  void addWelcomeMessage(String message) {
    if (_welcomeItems.length < maxWelcome) {
      _welcomeItems.add(message);
      notifyListeners();
    }
  }

  void updateWelcomeMessage(int index, String newText) {
    if (index >= 0 && index < _welcomeItems.length) {
      _welcomeItems[index] = newText;
      notifyListeners();
    }
  }

  void deleteWelcomeMessage(int index) {
    if (index >= 0 && index < _welcomeItems.length) {
      _welcomeItems.removeAt(index);
      notifyListeners();
    }
  }

  void addCategory(String categoryName) {
    if (_categoryItems.length < maxCategory) {
      _categoryItems.add(categoryName);
      notifyListeners();
    }
  }

  void updateCategory(int index, String newText) {
    if (index >= 0 && index < _categoryItems.length) {
      _categoryItems[index] = newText;
      notifyListeners();
    }
  }

  void deleteCategory(int index) {
    if (index >= 0 && index < _categoryItems.length) {
      _categoryItems.removeAt(index);
      notifyListeners();
    }
  }

  void clear() {
    _welcomeItems = [];
    _categoryItems = [];
    notifyListeners();
    print('Test1ViewModel cleared: welcomeItems=$_welcomeItems, categoryItems=$_categoryItems');
  }
}