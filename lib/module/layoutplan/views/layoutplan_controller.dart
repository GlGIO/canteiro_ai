import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutplan_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getlayoutplan_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/getlayoutplan_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LayoutPlanController {
  final GetLayoutPlanUsecase getLayoutPlanUsecase;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  late int layoutId;

  late PageController pageController;

  List<LayoutPlanEntity> layoutAreas = <LayoutPlanEntity>[];

  LayoutPlanController({
    required this.getLayoutPlanUsecase,
  });

  Future<void> setId(LayoutInfoEntity layout) async {
    layoutId = layout.id;
  }

  Future<void> fetchLayoutPlan() async {
    isLoading.value = true;

    try {
      layoutAreas =
          await getLayoutPlanUsecase(GetLayoutPlanParams(id: layoutId));
      debugPrint('layoutAreas: $layoutAreas');
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
  }

  void goToHome() {
    Modular.to.popAndPushNamed('/home/queue/');
  }
}
