import 'package:canteiro_ai/module/layoutinfo/domain/params/getlayoutplan_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/typedefs/layoutinfo_typedef.dart';

class GetLayoutPlanUsecase {
  final LayoutInfoRepository repository;

  GetLayoutPlanUsecase(this.repository);

  GetLayoutPlanResult call(GetLayoutPlanParams params) {
    return repository.getLayoutPlan(params);
  }
}
