import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/queue/views/queue_controller.dart';
import 'package:canteiro_ai/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  final QueueController controller = Modular.get();

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  void _fetch() async {
    await controller.fetchLayouts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      pageTitle: 'Layouts',
      bodyContent: Column(
        children: [
          for (final LayoutInfoEntity layout in controller.optionsChecklist)
            InkWell(
              onTap: () {
                Modular.to.navigate('/home/layoutPlan/', arguments: layout);
              },
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            layout.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.formatDate(layout.date),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        layout.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        layout.local,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
