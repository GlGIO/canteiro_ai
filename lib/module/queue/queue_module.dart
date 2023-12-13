import 'package:canteiro_ai/module/home/home_module.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/getalllayouts_usecase.dart';
import 'package:canteiro_ai/module/layoutinfo/infra/layoutinfo_repository_imp.dart';
import 'package:canteiro_ai/module/queue/views/queue_controller.dart';
import 'package:canteiro_ai/module/queue/views/queue_page.dart';
import 'package:canteiro_ai/util/db.dart';
import 'package:flutter_modular/flutter_modular.dart';

class QueueModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const QueuePage());
  }

  @override
  void binds(i) {
    i.addSingleton(DatabaseSQFlite.new);
    i.add<LayoutInfoRepository>(LayoutInfoRepositoryImp.new);
    i.add(GetAllLayoutsUseCase.new);
    i.add(QueueController.new);
  }

  @override
  List<Module> get imports => [
        HomeModule(),
      ];
}
