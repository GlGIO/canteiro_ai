import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String pageTitle;
  final Widget bodyContent;

  const Layout({
    super.key,
    required this.pageTitle,
    required this.bodyContent,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.pageTitle),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.bodyContent,
          ],
        ),
      ),
    );
  }
}
