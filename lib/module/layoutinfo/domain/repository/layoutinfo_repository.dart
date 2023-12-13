import 'package:canteiro_ai/module/layoutinfo/domain/params/addnewlayout_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getalllayouts_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getlayoutplan_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/typedefs/layoutinfo_typedef.dart';

abstract class LayoutInfoRepository {
  GetAllLayoutsResult getAllLayouts(GetAllLayoutsParams params);
  AddNewLayoutResult addNewLayout(AddNewLayoutParams params);
  GetLayoutPlanResult getLayoutPlan(GetLayoutPlanParams params);
}
