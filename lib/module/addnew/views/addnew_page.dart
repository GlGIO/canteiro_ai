import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:canteiro_ai/module/addnew/views/addnew_controller.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/widgets/input_text.dart';
import 'package:canteiro_ai/widgets/layout.dart';
import 'package:canteiro_ai/widgets/select_tex.dart';
import 'package:canteiro_ai/widgets/snackbar_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddnewPage extends StatefulWidget {
  const AddnewPage({super.key});

  @override
  State<AddnewPage> createState() => _AddnewPageState();
}

class _AddnewPageState extends State<AddnewPage> {
  @override
  void initState() {
    super.initState();

    controller.index.addListener(() {
      setState(() {});
    });

    controller.isLoading.addListener(() {
      setState(() {});
    });

    controller.error.addListener(() {
      if (controller.error.value != null) {
        showSnackBar(context: context, message: controller.error.value!);
        controller.error.value = null;
      }
    });
  }

  final AddnewController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<TipoEdificacao>> typesEdf =
        <DropdownMenuEntry<TipoEdificacao>>[];
    for (TipoEdificacao typeEdf in TipoEdificacao.values) {
      typesEdf.add(
        DropdownMenuEntry<TipoEdificacao>(value: typeEdf, label: typeEdf.name),
      );
    }

    final List<DropdownMenuEntry<TipoCanteiro>> typesCant =
        <DropdownMenuEntry<TipoCanteiro>>[];
    for (TipoCanteiro typeCant in TipoCanteiro.values) {
      typesCant.add(
        DropdownMenuEntry<TipoCanteiro>(
          value: typeCant,
          label: typeCant.name,
        ),
      );
    }

    final List<DropdownMenuEntry<EtapaObra>> stages =
        <DropdownMenuEntry<EtapaObra>>[];
    for (EtapaObra stage in EtapaObra.values) {
      stages.add(
        DropdownMenuEntry<EtapaObra>(
          value: stage,
          label: stage.name,
        ),
      );
    }

    return controller.isLoading.value
        ? Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorsTheme.gradient,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: const Image(
                    image: AssetImage(
                      'assets/images/robot.gif',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Canteiro AI: \n\nEstou trabalhando para encontrar o melhor Layout para você!',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontFamily: 'coda-regular',
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          )
        : Layout(
            pageTitle: 'Novo Layout',
            bodyContent: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.09,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: const Divider(
                              color: ColorsTheme.primary,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stepper(
                      type: StepperType.horizontal,
                      elevation: 0,
                      currentStep: controller.index.value,
                      connectorColor:
                          MaterialStateProperty.all(Colors.transparent),
                      stepIconBuilder: (stepIndex, state) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorsTheme.secondary, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: stepIndex <= controller.index.value
                                ? ColorsTheme.secondary
                                : ColorsTheme.backgroundField,
                            child: Text(
                              '${stepIndex + 1}',
                              style: TextStyle(
                                color: stepIndex <= controller.index.value
                                    ? Colors.white
                                    : ColorsTheme.textGrey,
                                fontFamily: 'roboto-medium',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      steps: <Step>[
                        Step(
                          title: const Text(
                            '',
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.63,
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Informações',
                                      style: TextStyle(
                                          color: ColorsTheme.primary,
                                          fontFamily: 'roboto-medium',
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                InputTextField(
                                  controller: controller.titleController,
                                  label: 'Título',
                                  hintText: 'Título do layout',
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InputTextField(
                                  controller: controller.descriptionController,
                                  label: 'Descrição',
                                  hintText: 'Descrição do layout',
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InputTextField(
                                  controller: controller.localController,
                                  label: 'Local',
                                  hintText: 'Local do layout',
                                  keyboardType: TextInputType.text,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Step(
                          title: const Text(
                            '',
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.63,
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Definições',
                                      style: TextStyle(
                                          color: ColorsTheme.primary,
                                          fontFamily: 'roboto-medium',
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                SelectText(
                                  controller: controller.typeEdfController,
                                  label: 'Tipo de edificação',
                                  hintText: 'Selecione o tipo de edificação',
                                  dropdownMenuEntries: typesEdf,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                SelectText(
                                  controller: controller.typeCantController,
                                  label: 'Tipo do canteiro',
                                  hintText: 'Selecione o tipo do caanteiro',
                                  dropdownMenuEntries: typesCant,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                SelectText(
                                  controller: controller.stageController,
                                  label: 'Estágio da edificação',
                                  hintText: 'Selecione o estágio da edificação',
                                  dropdownMenuEntries: stages,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Step(
                          title: const Text(
                            '',
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.63,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Dimensões',
                                        style: TextStyle(
                                            color: ColorsTheme.primary,
                                            fontFamily: 'roboto-medium',
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller: controller.larguraController,
                                    label: 'Largura',
                                    hintText: 'Largura do terreno',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller:
                                        controller.profundidadeController,
                                    label: 'Profundidade',
                                    hintText: 'Profundidade do terreno',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller: controller.inicioACXController,
                                    label: 'x da Área Construida',
                                    hintText: 'x (do inicio da construção)',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller: controller.fimACXController,
                                    label: 'x da Área Construida',
                                    hintText: 'x (do fim da construção)',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller: controller.inicioACYController,
                                    label: 'y da Área Construida',
                                    hintText: 'y (do inicio da construção)',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    controller: controller.fimACYController,
                                    label: 'y da Área Construida',
                                    hintText: 'y (do fim da construção)',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return buildButtonNavigation();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildButtonNavigation() => Row(
        mainAxisAlignment: controller.isFirstStep
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        children: [
          if (!controller.isFirstStep)
            TextButton(
              onPressed: controller.previousStep,
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: ColorsTheme.backgroundField,
                  fontFamily: 'roboto-medium',
                ),
              ),
            ),
          TextButton(
            onPressed: controller.nextStep,
            child: Text(
              controller.isLastStep ? 'Concluir' : 'Avançar',
              style: TextStyle(
                color: controller.isLastStep
                    ? ColorsTheme.primary
                    : ColorsTheme.backgroundField,
                fontFamily: 'roboto-medium',
              ),
            ),
          ),
        ],
      );
}
