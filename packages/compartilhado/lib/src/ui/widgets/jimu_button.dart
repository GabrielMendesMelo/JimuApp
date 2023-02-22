import 'package:flutter/material.dart';

class JimuButton extends StatelessWidget {
  const JimuButton({
    this.tipo = JimuButtonTipo.circular,
    this.foregroundColor,
    this.backgroundColor,
    this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.paddingLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.texto,
    this.textoCentro = false,
    this.autofocus = false,
    this.child,
    super.key,
  });

  final JimuButtonTipo tipo;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;
  final Text? texto;
  final bool textoCentro;
  final bool autofocus;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Color foreground = foregroundColor ??
        Theme.of(context).buttonTheme.colorScheme!.inversePrimary;
    final Color background =
        backgroundColor ?? Theme.of(context).buttonTheme.colorScheme!.primary;

    final ButtonStyle style = ButtonStyle(
      foregroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return states.contains(MaterialState.disabled) ? null : foreground;
      }),
      backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return states.contains(MaterialState.disabled) ? null : background;
      }),
    );

    switch (tipo) {
      case JimuButtonTipo.rect:
        return TextButton(
          style: style,
          onPressed: onPressed,
          autofocus: autofocus,
          child: child ?? _child(),
        );
      case JimuButtonTipo.circular:
        return FloatingActionButton(
          foregroundColor: foreground,
          backgroundColor: background,
          onPressed: onPressed,
          autofocus: autofocus,
          child: child ?? _child(),
        );
    }
  }

  Widget _child() {
    if (width != null || height != null) {
      return _sizedBox(
        _padding(
          texto != null ? _text(texto!) : null,
        ),
      );
    } else {
      return _padding(texto != null ? _text(texto!) : null);
    }
  }

  SizedBox _sizedBox(Widget child) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  Padding _padding(Widget? child) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: 16,
            top: 8,
            right: 16,
            bottom: 8,
          ),
      child: child,
    );
  }

  Widget _text(Text text) {
    if (textoCentro) {
      return Center(
        child: text,
      );
    }
    return text;
  }
}

enum JimuButtonTipo {
  rect,
  circular,
}
