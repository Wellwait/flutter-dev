import 'dart:io';

import 'package:flutter/cupertino.dart';

class NotificationViewModel extends ChangeNotifier {


  refreshUI() {
    notifyListeners();
  }

}
