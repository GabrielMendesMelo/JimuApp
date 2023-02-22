import 'package:flutter/material.dart';

import 'package:compartilhado/compartilhado.dart';
import 'package:alimentos/src/api/api.dart';
import 'package:alimentos/src/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlimentosFormModal extends StatefulWidget {
  const AlimentosFormModal({super.key});

  @override
  State<AlimentosFormModal> createState() => _AlimentosFormModalState();
}

class _AlimentosFormModalState extends State<AlimentosFormModal> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JimuModal(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _alimentosForm(
              _nomeController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _alimentosForm(
    TextEditingController nomeController,
  ) {
    return Card(
      child: JimuForm(
        titulo: 'Cadastrar alimento',
        submitText: 'Cadastrar',
        onSubmitted: () async {
          context.read<AlimentosBloc>().add(
                AlimentosAdicionouAlimento(
                  alimento: Alimento(
                    nome: nomeController.text.formatar(),
                  ),
                ),
              );
          await _onSubmitted(
            <TextEditingController>[
              nomeController,
            ],
          );
        },
        textControllers: <TextEditingController>[
          nomeController,
        ],
        children: _children(
          nomeController,
        ),
      ),
    );
  }

  List<JimuFormWidget> _children(
    TextEditingController nomeController,
  ) {
    return <JimuFormWidget>[
      NomeTextFormField(
        validatorText: 'Insira um nome válido.',
        controller: nomeController,
        label: 'Nome',
        validatorMinLength: 2,
      ),
      NomeTextFormField(
        validatorText: 'Insira um nome válido.',
        controller: nomeController,
        label: 'Nome',
        validatorMinLength: 2,
      ),
    ];
  }

  Future<void> _onSubmitted(List<TextEditingController> controllers) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          BlocBuilder<AlimentosBloc, AlimentosState>(
        builder: (BuildContext context, AlimentosState state) {
          switch (state.runtimeType) {
            case AlimentosAdicionandoAlimentoSucesso:
              return JimuConfirmacaoDialog(
                subtituloTexto:
                    '${(state as AlimentosAdicionandoAlimentoSucesso).alimento.nome} foi adicionado com sucesso!',
                apenasConfirmacao: true,
                confirmarOnPressed: () {
                  for (final TextEditingController c in controllers) {
                    c.clear();
                  }
                  Navigator.of(context).pop();
                },
              );

            case AlimentosAdicionandoAlimentoFalha:
              return JimuConfirmacaoDialog(
                apenasConfirmacao: true,
                subtituloTexto: (state as JimuStateFalha).erroMsg,
              );

            case AlimentosAdicionandoAlimentoEmProgresso:
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    ).then(
      (void value) => Navigator.of(context).pop(),
    );
  }
}
