import 'package:flutter/material.dart';

import '../model/learnmore_model.dart';
import '../repo/learnmore_repo.dart';

class LearnMore extends ChangeNotifier {
  late List<LearnMoreModel> learnmore = [];

  fetchData(context) async {
    learnmore = await learnMoreModelData(context);
    notifyListeners();
  }
}
