import 'package:canteiro_ai/widgets/layout.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
        pageTitle: 'Configurações',
        bodyContent: Column(
          children: [
            Center(
              child: Text('Centro'),
            ),
          ],
        ));
  }
}
