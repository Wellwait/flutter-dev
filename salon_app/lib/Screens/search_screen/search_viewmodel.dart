import 'dart:io';

import 'package:flutter/cupertino.dart';

class SearchViewModel extends ChangeNotifier {


  refreshUI() {
    notifyListeners();
  }

}
