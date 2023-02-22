import 'package:flutter/material.dart';

import 'package:compartilhado/compartilhado.dart';

/// [titulo] e [tituloTexto] não podem ter valor ao mesmo tempo
/// [subtitulo] e [subtituloTexto] não podem ter valor ao mesmo tempo
/// [botaoCancelar] e [cancelarOnPressed] não podem ter valor ao mesmo tempo
/// [botaoConfirmar] e [confirmarOnPressed] não podem ser nulos ou ter valor ao mesmo tempo

class JimuConfirmacaoDialog extends StatelessWidget {
  final Color? backgroundColor;
  final double height;
  final double width;
  final Decoration? decoration;
  final Text? titulo;
  final String? tituloTexto;
  final Text? subtitulo;
  final String? subtituloTexto;
  final bool apenasConfirmacao;
  final Widget? botaoCancelar;
  final dynamic Function()? cancelarOnPressed;
  final Widget? botaoConfirmar;
  final dynamic Function()? confirmarOnPressed;

  const JimuConfirmacaoDialog({
    this.backgroundColor,
    this.height = 300,
    this.width = 400,
    this.decoration,
    this.titulo,
    this.tituloTexto,
    this.subtitulo,
    this.subtituloTexto,
    this.apenasConfirmacao = false,
    this.botaoCancelar,
    this.cancelarOnPressed,
    this.botaoConfirmar,
    this.confirmarOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    _jimuConfirmacaoDialogErros();

    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor ?? Theme.of(context).colorScheme.background,
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _titulo(context),
            _subtitulo(context),
            _botoes(context),
          ],
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context) {
    Widget? child;
    if (titulo != null) {
      child = titulo!;
    }
    if (tituloTexto != null) {
      child = Text(
        tituloTexto!,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(32),
      child: child,
    );
  }

  Widget _subtitulo(BuildContext context) {
    Widget? child;
    if (subtitulo != null) {
      child = subtitulo;
    }
    if (subtituloTexto != null) {
      child = Text(
        subtituloTexto!,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _botoes(BuildContext context) {
    final List<Widget> children = <Widget>[];

    if (botaoCancelar != null) {
      children.add(botaoCancelar!);
    } else {
      if (apenasConfirmacao) {
        children.add(const SizedBox());
      } else {
        children.add(
          JimuButton(
            backgroundColor: Theme.of(context).colorScheme.error,
            onPressed: cancelarOnPressed ?? () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
            ),
          ),
        );
      }
    }

    if (botaoConfirmar != null) {
      children.add(botaoConfirmar!);
    } else {
      children.add(
        JimuButton(
          autofocus: true,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: confirmarOnPressed ?? () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.check,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 64,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  void _jimuConfirmacaoDialogErros() {
    if (titulo != null && tituloTexto != null) {
      throw ArgumentError(
          'titulo e tituloTexto não podem ter valor ao mesmo tempo');
    }
    if (subtitulo != null && subtituloTexto != null) {
      throw ArgumentError(
          'subtitulo e subtituloTexto não podem ter valor ao mesmo tempo');
    }
    if (botaoCancelar != null && cancelarOnPressed != null) {
      throw ArgumentError(
          'botaoCancelar e cancelarOnPressed não podem ter valor ao mesmo tempo');
    }
    if (botaoConfirmar != null && confirmarOnPressed != null) {
      throw ArgumentError(
          'botaoConfirmar e confirmarOnPressed não podem ter valor ao mesmo tempo');
    }
  }
}
