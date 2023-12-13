import 'package:canteiro_ai/module/addnew/views/addnew_controller.dart';
import 'package:canteiro_ai/module/addnew/views/addnew_page.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/addnewlayout_usecase.dart';
import 'package:canteiro_ai/module/layoutinfo/infra/layoutinfo_repository_imp.dart';
import 'package:canteiro_ai/util/db.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddnewModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const AddnewPage(),
    );
  }

  @override
  void binds(i) {
    i.addSingleton(DatabaseSQFlite.new);
    i.add<LayoutInfoRepository>(LayoutInfoRepositoryImp.new);
    i.add(AddNewLayoutUseCase.new);
    i.add(AddnewController.new);
  }
}
