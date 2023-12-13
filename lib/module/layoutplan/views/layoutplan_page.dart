import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutplan/views/layoutplan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LayoutPlanPage extends StatefulWidget {
  final LayoutInfoEntity layout;

  const LayoutPlanPage({super.key, required this.layout});

  @override
  State<LayoutPlanPage> createState() => LayoutPlanPageState();
}

class LayoutPlanPageState extends State<LayoutPlanPage> {
  late final LayoutPlanController controller;

  bool change = false;

  @override
  void initState() {
    super.initState();
    controller = Modular.get();
    controller.setId(widget.layout);
    controller.pageController = PageController();
    _fetch();
  }

  void _fetch() async {
    await controller.fetchLayoutPlan();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => controller.goToHome(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Center(
            child: Column(
              children: [
                Text(widget.layout.title),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard('Descrição:', widget.layout.description),
                _buildCard('Localização', widget.layout.local),
                _buildCard('Tipo de Edificação', widget.layout.typeEdf),
                _buildCard('Tipo de Canteiro', widget.layout.typeCant),
                _buildCard('Etapa da Obra', widget.layout.stage),
                _buildCard('Área',
                    '${widget.layout.largura * widget.layout.profundidade} m²'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(child: _buildLayoutContainer()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            change
                ? {
                    controller.pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    setState(() {
                      change = !change;
                    })
                  }
                : {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    setState(() {
                      change = !change;
                    })
                  };
          },
          child: Icon(
            change ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
          )),
    );
  }

  _buildCard(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: ColorsTheme.primary),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              softWrap: true,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Theme.of(context).cardColor,
      ),
      width: widget.layout.largura * 20,
      height: widget.layout.profundidade * 20,
      child: Stack(
        children: _buildLayoutAreas(),
      ),
    );
  }

  List<Widget> _buildLayoutAreas() {
    return controller.layoutAreas.map(
      (area) {
        return Positioned(
          left: area.x1 * 20,
          bottom: area.y1 * 20, // Usar bottom em vez de top
          width: (area.x2 - area.x1) * 20,
          height: (area.y2 - area.y1) * 20,
          child: RotatedBox(
            quarterTurns: 1, // Rotacionar 90 graus no sentido anti-horário
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: ColorsTheme.primary,
              ),
              child: Center(
                child: Text(
                  area.areaName,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 10, overflow: TextOverflow.visible),
                ),
              ),
            ),
          ),
        );
      },
    ).toList();
  }
}
