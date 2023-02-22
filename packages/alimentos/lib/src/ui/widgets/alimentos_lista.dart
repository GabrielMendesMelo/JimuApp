import 'package:flutter/material.dart';

import 'package:alimentos/src/api/api.dart';
import 'package:alimentos/src/bloc/bloc.dart';
import 'package:compartilhado/compartilhado.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlimentosLista extends StatelessWidget {
  const AlimentosLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: BlocBuilder<AlimentosBloc, AlimentosState>(
          builder: (BuildContext context, AlimentosState state) {
            switch (state.runtimeType) {
              case AlimentosInicial:
              case AlimentosCarregandoEmProgresso:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AlimentosRemovendoAlimentoFalha:
              case AlimentosCarregandoFalha:
                final String falhaTxt = (state as JimuStateFalha).erroMsg;

                return _lista(
                  alimentos: state.alimentos,
                  listaVaziaTexto: falhaTxt,
                  titulo: Text(
                    'Ocorreu uma falha ao sincronizar os alimentos: $falhaTxt',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                return _lista(
                  alimentos: state.alimentos,
                  listaVaziaTexto: 'Nenhum alimento cadastrado.',
                );
            }
          },
        ),
      ),
    );
  }

  Widget _lista({
    required List<Alimento> alimentos,
    required String listaVaziaTexto,
    Widget? titulo,
  }) {
    final List<Alimento> alimentosLista = alimentos;
    return alimentos.isNotEmpty
        ? ListView.separated(
            padding: const EdgeInsets.only(bottom: 32),
            itemCount: alimentosLista.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    titulo ?? const SizedBox(),
                    _AlimentoItem(
                      alimentosLista[index],
                    ),
                  ],
                );
              }
              return _AlimentoItem(
                alimentosLista[index],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(),
          )
        : Center(
            child: Text(listaVaziaTexto),
          );
  }
}

class _AlimentoItem extends StatelessWidget {
  final Alimento alimento;

  const _AlimentoItem(
    this.alimento,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: JimuCard(
        titulo: alimento.nome,
        subtitulo: 'subtítulo',
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 150,
              ),
              SizedBox(
                width: 80,
                child: Text(
                  'Valor',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'Valor diário (%)',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          for (Widget alimento in _alimentosValores(
            context,
            alimento,
          ))
            alimento,
        ],
      ),
      trailing: JimuButton(
        child: const Icon(
          Icons.remove,
        ),
        onPressed: () async {
          _removerAlimento(
            context,
            alimento,
          );
        },
      ),
    );
  }

  List<Widget> _alimentosValores(
    BuildContext context,
    Alimento alimento,
  ) {
    return <Widget>[
      _valorItem(
        context,
        // alimento.calorias
      ),
      _valorItem(
        context,
        // alimento.carboidratos
      ),
      _valorItem(
        context,
        // alimento.proteinas
      ),
      _valorItem(
        context,
        // alimento.gordurasTotais
      ),
      _valorItem(
        context,
        // alimento.gordurasSaturadas
      ),
      _valorItem(
        context,
        // alimento.sodio
      ),
      _valorItem(
        context,
        // alimento.fibraAlimentar
      ),
    ];
  }

  Widget _valorItem(
    BuildContext context,
    // Valor valor,
  ) {
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              // valor.nome
              'Gorduras Saturadas',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              // valor.valor.toStringAsFixed(2),
              12.81924678123912.toStringAsFixed(2),
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              // valor.valorDiario.toStringAsFixed(2),
              4.8392.toStringAsFixed(2),
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removerAlimento(
    BuildContext context,
    Alimento alimento,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => JimuConfirmacaoDialog(
        tituloTexto: 'Tem certeza que deseja excluir ${alimento.nome}?',
        confirmarOnPressed: () async {
          context.read<AlimentosBloc>().add(
                AlimentosRemoveuAlimento(alimento: alimento),
              );
          Navigator.of(context).pop();
          await _removeuAlimento(context);
        },
      ),
    );
  }

  Future<void> _removeuAlimento(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          BlocBuilder<AlimentosBloc, AlimentosState>(
        builder: (BuildContext context, AlimentosState state) {
          switch (state.runtimeType) {
            case AlimentosRemovendoAlimentoEmProgresso:
              return const Center(child: CircularProgressIndicator());
            case AlimentosRemovendoAlimentoFalha:
              return JimuConfirmacaoDialog(
                subtituloTexto: (state as JimuStateFalha).erroMsg,
                apenasConfirmacao: true,
              );
            default:
              return JimuConfirmacaoDialog(
                subtituloTexto:
                    '${(state as AlimentosRemovendoAlimentoSucesso).alimento.nome} foi removido com sucesso!',
                apenasConfirmacao: true,
              );
          }
        },
      ),
    );
  }
}
