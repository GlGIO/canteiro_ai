import 'package:canteiro_ai/module/config/views/config_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const ConfigPage(),
    );
  }

  @override
  void binds(i) {}
}
