import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/home/queue/');

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'roboto-regular',
        primaryColor: ColorsTheme.primary,
        brightness: Brightness.dark,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
