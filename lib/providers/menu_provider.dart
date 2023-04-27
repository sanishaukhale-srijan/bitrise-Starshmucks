import 'package:flutter/material.dart';

import '../model/menu_model.dart';

class Menudata extends ChangeNotifier {
  late List<MenuModel> cakemenudata = [];
  late List<MenuModel> coffeemenudata = [];
  late List<MenuModel> smoothiemenudata = [];

  cakefetchData(context) async {
    notifyListeners();
  }

  coffeefetchData(context) async {
    notifyListeners();
  }

  smoothiefetchData(context) async {
    notifyListeners();
  }
}
