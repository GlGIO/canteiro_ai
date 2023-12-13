import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/getlayoutplan_usecase.dart';
import 'package:canteiro_ai/module/layoutinfo/infra/layoutinfo_repository_imp.dart';
import 'package:canteiro_ai/module/layoutplan/views/layoutplan_controller.dart';
import 'package:canteiro_ai/module/layoutplan/views/layoutplan_page.dart';
import 'package:canteiro_ai/util/db.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LayoutPlanModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(DatabaseSQFlite.new);
    i.addLazySingleton(LayoutPlanController.new);
    i.add<LayoutInfoRepository>(LayoutInfoRepositoryImp.new);
    i.add(GetLayoutPlanUsecase.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => LayoutPlanPage(
        layout: r.args.data as LayoutInfoEntity,
      ),
    );
  }
}
