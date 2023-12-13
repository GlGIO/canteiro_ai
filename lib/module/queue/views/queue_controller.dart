import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getalllayouts_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/getalllayouts_usecase.dart';
import 'package:flutter/material.dart';

class QueueController {
  final GetAllLayoutsUseCase getAllLayoutsUseCase;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  List<LayoutInfoEntity> optionsChecklist = <LayoutInfoEntity>[];

  QueueController({
    required this.getAllLayoutsUseCase,
  });

  Future<void> fetchLayouts() async {
    isLoading.value = true;

    try {
      optionsChecklist = await getAllLayoutsUseCase(GetAllLayoutsParams());
      debugPrint('optionsChecklist: $optionsChecklist');
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
  }
}
