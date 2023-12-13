import 'package:canteiro_ai/module/layoutinfo/domain/params/addnewlayout_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/usecase/addnewlayout_usecase.dart';
import 'package:canteiro_ai/util/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddnewController {
  final AddNewLayoutUseCase addNewLayoutUseCase;

  final ValueNotifier<int> index = ValueNotifier(0);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  //control step
  bool get isFirstStep => index.value == 0;
  bool get isLastStep => index.value == steps - 1;
  int steps = 3;

  //Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController localController = TextEditingController();

  final TextEditingController typeEdfController = TextEditingController();
  final TextEditingController typeCantController = TextEditingController();
  final TextEditingController stageController = TextEditingController();

  final TextEditingController larguraController = TextEditingController();
  final TextEditingController profundidadeController = TextEditingController();

  final TextEditingController inicioACXController = TextEditingController();
  final TextEditingController fimACXController = TextEditingController();
  final TextEditingController inicioACYController = TextEditingController();
  final TextEditingController fimACYController = TextEditingController();

  AddnewController({
    required this.addNewLayoutUseCase,
  });

  Future<bool> addNewLayout() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        localController.text.isEmpty ||
        typeEdfController.text.isEmpty ||
        typeCantController.text.isEmpty ||
        stageController.text.isEmpty ||
        larguraController.text.isEmpty ||
        profundidadeController.text.isEmpty ||
        inicioACXController.text.isEmpty ||
        fimACXController.text.isEmpty ||
        inicioACYController.text.isEmpty ||
        fimACYController.text.isEmpty) {
      error.value = 'Algum campo está vazio';
      return false;
    }

    try {
      isLoading.value = true;
      await addNewLayoutUseCase(
        AddNewLayoutParams(
          title: titleController.text,
          local: localController.text,
          description: descriptionController.text,
          typeEdf: typeEdfController.text,
          typeCant: typeCantController.text,
          stage: stageController.text,
          largura: double.parse(larguraController.text),
          profundidade: double.parse(profundidadeController.text),
          inicioACXController: double.parse(inicioACXController.text),
          fimACXController: double.parse(fimACXController.text),
          inicioACYController: double.parse(inicioACYController.text),
          fimACYController: double.parse(fimACYController.text),
        ),
      );
      isLoading.value = false;
      Modular.to.navigate('/home/queue/');
      return true;
    } on FieldsRequiredException catch (e) {
      error.value = e.message;
    }
    isLoading.value = false;
    return false;
  }

  void previousStep() {
    if (index.value > 0) {
      index.value--;
    }
  }

  void nextStep() {
    if (index.value + 1 == steps) {
      addNewLayout();
    } else {
      index.value++;
    }
  }
}
