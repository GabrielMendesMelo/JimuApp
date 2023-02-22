import 'package:flutter/material.dart';

import 'package:compartilhado/src/ui/ui.dart';

class JimuForm extends StatefulWidget {
  const JimuForm({
    required this.textControllers,
    required this.onSubmitted,
    required this.children,
    this.titulo,
    this.submitButton,
    this.submitText,
    this.padding,
    super.key,
  });

  final List<TextEditingController> textControllers;
  final void Function() onSubmitted;
  final List<JimuFormWidget> children;
  final String? titulo;
  final Widget? submitButton;
  final String? submitText;
  final EdgeInsets? padding;

  @override
  State<JimuForm> createState() => _JimuFormState();
}

class _JimuFormState extends State<JimuForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        onChanged: _updateFormProgress,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedProgressIndicator(
              value: _formProgress,
              tweenSequenceItens: <TweenSequenceItem<Color?>>[
                TweenSequenceItem<Color?>(
                  tween: ColorTween(
                    begin: const Color.fromARGB(255, 219, 196, 196),
                    end: const Color.fromARGB(255, 156, 203, 218),
                  ),
                  weight: 2,
                ),
                TweenSequenceItem<Color?>(
                  tween: ColorTween(
                    begin: const Color.fromARGB(255, 156, 203, 218),
                    end: const Color.fromARGB(255, 100, 162, 182),
                  ),
                  weight: 2,
                ),
                TweenSequenceItem<Color?>(
                  tween: ColorTween(
                    begin: const Color.fromARGB(255, 100, 162, 182),
                    end: const Color.fromARGB(255, 0, 128, 171),
                  ),
                  weight: 1,
                ),
              ],
            ),
            _conteudo(),
          ],
        ),
      ),
    );
  }

  Widget _conteudo() {
    EdgeInsets? padding = widget.padding;
    if (padding == null) {
      final double width = MediaQuery.of(context).size.width;
      if (width < 720) {
        padding = const EdgeInsets.all(16);
      } else if (width < 1000) {
        padding = EdgeInsets.symmetric(
          vertical: 16,
          horizontal: width / 9,
        );
      } else {
        padding = EdgeInsets.symmetric(
          vertical: 16,
          horizontal: width / 5,
        );
      }
    }

    return Padding(
      padding: padding,
      child: Column(
        children: <Widget>[
          _titulo(),
          for (Widget c in widget.children) c,
          _submitButton(),
        ],
      ),
    );
  }

  Widget _titulo() {
    return widget.titulo != null
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.titulo!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : const SizedBox();
  }

  Widget _submitButton() {
    return widget.submitButton ??
        Padding(
          padding: const EdgeInsets.all(32),
          child: JimuButton(
            tipo: JimuButtonTipo.rect,
            padding: const EdgeInsets.all(16),
            onPressed: _formProgress == 1 ? _onSubmitted : null,
            texto: Text(
              widget.submitText ?? 'Enviar',
            ),
          ),
        );
  }

  void _updateFormProgress() {
    double progress = 0;
    for (final TextEditingController c in widget.textControllers) {
      if (c.value.text.isNotEmpty) {
        progress += 1 / widget.textControllers.length;
      }
    }
    setState(() {
      _formProgress = progress;
    });
  }

  void _onSubmitted() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmitted();
    }
  }
}
