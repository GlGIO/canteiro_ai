import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutplan_entity.dart';

typedef GetAllLayoutsResult = Future<List<LayoutInfoEntity>>;
typedef AddNewLayoutResult = Future<void>;
typedef GetLayoutPlanResult = Future<List<LayoutPlanEntity>>;
