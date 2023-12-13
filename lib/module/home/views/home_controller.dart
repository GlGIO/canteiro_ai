import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeController {
  ValueNotifier<int> currentIndexBottomNavigation = ValueNotifier<int>(0);

  void onTapBottomNavigationBarItem(int index) {
    currentIndexBottomNavigation.value = index;
    goToRoute(index);
  }

  void goToRoute(int index) {
    String route = '';

    switch (index) {
      case 0:
        route = '/home/queue/';
        break;
      case 1:
        route = '/home/addnew/';
        break;
      case 2:
        route = '/home/config/';
        break;
    }

    if (route.isNotEmpty) {
      Modular.to.navigate(route);
    }
  }
}
