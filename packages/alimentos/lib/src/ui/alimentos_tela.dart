import 'package:flutter/material.dart';

import 'package:alimentos/src/bloc/bloc.dart';
import 'package:alimentos/src/ui/ui.dart';
import 'package:compartilhado/compartilhado.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AlimentosTela extends StatefulWidget {
  const AlimentosTela({super.key});

  @override
  State<AlimentosTela> createState() => _AlimentosTelaState();
}

class _AlimentosTelaState extends State<AlimentosTela> {

  @override
  Future<void> dispose() async {
    context.read<AlimentosBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alimentos'),
        actions: _actions(),
      ),
      body: _alimentosBody(),
    );
  }

  List<Widget>? _actions() {
    const EdgeInsets padding = EdgeInsets.symmetric(vertical: 8);
    return <Widget>[
      Padding(
        padding: padding,
        child: JimuButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => const AlimentosFormModal(),
            ).then(
              (void value) => context.read<AlimentosBloc>().add(
                    AlimentosCarregouAlimentos(),
                  ),
            );
          },
        ),
      ),
      Padding(
        padding: padding,
        child: JimuButton(
          child: const Icon(Icons.sync),
          onPressed: () {
            context.read<AlimentosBloc>().add(
                  AlimentosCarregouAlimentos(),
                );
          },
        ),
      ),
    ];
  }

  Widget _alimentosBody() {
    return BlocBuilder<AlimentosBloc, AlimentosState>(
      buildWhen: (
        AlimentosState previous,
        AlimentosState current,
      ) =>
          current is AlimentosInicial ||
          current is AlimentosCarregandoEmProgresso ||
          current is AlimentosCarregandoSucesso ||
          current is AlimentosCarregandoFalha,
      builder: (
        BuildContext context,
        AlimentosState state,
      ) {
        switch (state.runtimeType) {
          case AlimentosInicial:
          case AlimentosCarregandoEmProgresso:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return const AlimentosLista();
        }
      },
    );
  }
}
