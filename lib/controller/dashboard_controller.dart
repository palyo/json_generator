import 'package:flutter/material.dart';

class DasboardController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int _pageIndex = 0;

  void setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  int get pageIndex => _pageIndex;
}
