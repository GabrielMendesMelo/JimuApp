import 'package:flutter/material.dart';

/// [appBar] e [appBarTitulo] não podem ter valor ao mesmo tempo

class JimuModal extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final String? appBarTitulo;

  const JimuModal({
    required this.body,
    this.appBar,
    this.appBarTitulo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    _jimuModalErros();

    return Scaffold(
      appBar: appBar ??
          AppBar(
            centerTitle: true,
            title: Text(appBarTitulo ?? ''),
            leading: const BackButton(),
          ),
      body: body,
    );
  }

  void _jimuModalErros() {
    if (appBar != null && appBarTitulo != null) {
      throw ArgumentError(
          'appBar e appBarTitulo não podem ter valor ao mesmo tempo');
    }
  }
}
