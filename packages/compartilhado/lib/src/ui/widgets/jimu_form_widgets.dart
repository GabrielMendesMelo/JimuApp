import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:compartilhado/src/ui/ui.dart';

abstract class JimuFormWidget extends StatelessWidget {
  const JimuFormWidget({super.key});
}

class NomeTextFormField extends _JimuTextFormField {
  const NomeTextFormField({
    required this.validatorText,
    required TextEditingController controller,
    required String label,
    this.validatorMinLength,
    this.validatorMaxLength,
    EdgeInsets? padding,
    super.key,
  }) : super(
          controller: controller,
          label: label,
          padding: padding,
        );
  final String validatorText;
  final int? validatorMinLength;
  final int? validatorMaxLength;

  /// [validatorMinLength] deve ser maior ou igual a 0.

  @override
  Widget build(BuildContext context) {
    _nomeTextFormFieldErros();

    return _JimuTextFormField(
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.name,
      inputFormatters: inputFormatters ??
          <TextInputFormatter>[
            NomeTextFormatter(),
            // ignore: unnecessary_string_escapes
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\-\ áÁàÀãÃâÂéÉêÊñÑíÍóÓôÔúÚ ']")),
          ],
      validator: (String? value) => _validator(value),
    );
  }

  void _nomeTextFormFieldErros() {
    if (validatorMinLength != null) {
      if (validatorMinLength! < 0) {
        throw ArgumentError('validatorMinLength deve ser maior ou igual a 0.');
      }
    }
  }

  String? _validator(String? value) {
    bool maiorQueMin = true;
    bool menorQueMax = true;
    String validatorMsg = validatorText;

    if (value == null || value.isEmpty) {
      return validatorMsg;
    }

    if (validatorMinLength != null) {
      maiorQueMin = value.length >= validatorMinLength!;
      if (!maiorQueMin) {
        validatorMsg += ' Min $validatorMinLength caracteres.';
      }
    }
    if (validatorMaxLength != null) {
      menorQueMax = value.length <= validatorMaxLength!;
      if (!menorQueMax) {
        validatorMsg += ' Max $validatorMaxLength caracteres.';
      }
    }
    if (!maiorQueMin || !menorQueMax) {
      return validatorMsg;
    }
    return null;
  }
}

class _JimuTextFormField extends JimuFormWidget {
  const _JimuTextFormField({
    this.controller,
    this.label,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.padding,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: label != null ? Text(label!) : null,
          hintText: hintText,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
