import 'package:canteiro_ai/module/addnew/addnew_module.dart';
import 'package:canteiro_ai/module/config/config_module.dart';
import 'package:canteiro_ai/module/home/views/home_controller.dart';
import 'package:canteiro_ai/module/home/views/home_page.dart';
import 'package:canteiro_ai/module/layoutplan/layoutplan_module.dart';
import 'package:canteiro_ai/module/queue/queue_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const HomePage(),
      children: [
        ModuleRoute(
          '/queue',
          module: QueueModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/addnew',
          module: AddnewModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/config',
          module: ConfigModule(),
          transition: TransitionType.noTransition,
        )
      ],
    );
    r.module(
      '/layoutPlan/',
      module: LayoutPlanModule(),
      transition: TransitionType.noTransition,
    );
  }
}
