import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int _pageIndex = 0;

  void setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  int get pageIndex => _pageIndex;
}
