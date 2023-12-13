import 'package:canteiro_ai/module/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module(
      '/home/',
      module: HomeModule(),
    );
  }

  @override
  void binds(i) {}
}
