import 'package:alimentos/src/api/api.dart';
import 'package:compartilhado/compartilhado.dart';

abstract class AlimentosState extends JimuState {
  final List<Alimento> alimentos;

  const AlimentosState({
    required this.alimentos,
  });

  AlimentosState.vazio() : alimentos = <Alimento>[];

  @override
  List<Object?> get props => <Object>[alimentos];
}

class AlimentosInicial extends AlimentosState {
  AlimentosInicial() : super.vazio();
}

class AlimentosCarregandoEmProgresso extends AlimentosState {
  const AlimentosCarregandoEmProgresso(
    List<Alimento> alimentos,
  ) : super(
          alimentos: alimentos,
        );
}

class AlimentosCarregandoSucesso extends AlimentosState {
  const AlimentosCarregandoSucesso(
    List<Alimento> alimentos,
  ) : super(
          alimentos: alimentos,
        );
}

class AlimentosCarregandoFalha extends AlimentosState
    implements JimuStateFalha {
  @override
  final String erroMsg;

  const AlimentosCarregandoFalha(
    List<Alimento> alimentos,
    this.erroMsg,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[
        alimentos,
        erroMsg,
      ];
}

class AlimentosAdicionandoAlimentoEmProgresso extends AlimentosState {
  final Alimento alimento;
  const AlimentosAdicionandoAlimentoEmProgresso(
    List<Alimento> alimentos,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[alimento];
}

class AlimentosAdicionandoAlimentoSucesso extends AlimentosState {
  final Alimento alimento;
  const AlimentosAdicionandoAlimentoSucesso(
    List<Alimento> alimentos,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[alimento];
}

class AlimentosAdicionandoAlimentoFalha extends AlimentosState
    implements JimuStateFalha {
  @override
  final String erroMsg;
  final Alimento alimento;

  const AlimentosAdicionandoAlimentoFalha(
    List<Alimento> alimentos,
    this.erroMsg,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[
        alimentos,
        erroMsg,
      ];
}

class AlimentosRemovendoAlimentoEmProgresso extends AlimentosState {
  final Alimento alimento;
  const AlimentosRemovendoAlimentoEmProgresso(
    List<Alimento> alimentos,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[alimento];
}

class AlimentosRemovendoAlimentoSucesso extends AlimentosState {
  final Alimento alimento;
  const AlimentosRemovendoAlimentoSucesso(
    List<Alimento> alimentos,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[alimento];
}

class AlimentosRemovendoAlimentoFalha extends AlimentosState
    implements JimuStateFalha {
  @override
  final String erroMsg;
  final Alimento alimento;

  const AlimentosRemovendoAlimentoFalha(
    List<Alimento> alimentos,
    this.erroMsg,
    this.alimento,
  ) : super(
          alimentos: alimentos,
        );

  @override
  List<Object?> get props => <Object>[
        alimentos,
        erroMsg,
      ];
}
