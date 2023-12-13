import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:canteiro_ai/module/addnew/views/addnew_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AddnewController controller = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorsTheme.gradient,
          ),
        ),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewPadding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Canteiro AI',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: 'coda-regular',
                    color: ColorsTheme.primary,
                  ),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: ColorsTheme.loadindCircle,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
