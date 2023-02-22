import 'dart:async';

import 'package:alimentos/src/api/api.dart';
import 'package:alimentos/src/bloc/alimentos_event.dart';
import 'package:alimentos/src/bloc/alimentos_state.dart';
import 'package:compartilhado/compartilhado.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'alimentos_event.dart';
export 'alimentos_state.dart';

class AlimentosBloc extends Bloc<AlimentosEvent, AlimentosState> {
  final AlimentosCliente _alimentosCliente = AlimentosCliente();

  AlimentosBloc() : super(AlimentosInicial()) {
    on<AlimentosCarregouAlimentos>(onAlimentosCarregouAlimentos);
    on<AlimentosAdicionouAlimento>(onAlimentosAdicionouAlimento);
    on<AlimentosRemoveuAlimento>(onAlimentosRemoveuAlimento);
  }

  FutureOr<void> onAlimentosCarregouAlimentos(
    AlimentosCarregouAlimentos event,
    Emitter<AlimentosState> emit,
  ) async {
    emit(AlimentosCarregandoEmProgresso(state.alimentos));

    try {
      final List<Alimento> alimentos = await _alimentosCliente.getAlimentos();
      emit(
        AlimentosCarregandoSucesso(alimentos),
      );
    } catch (e) {
      emit(AlimentosCarregandoFalha(
        state.alimentos,
        e.toString().toExceptionMsg(),
      ));
    }
  }

  FutureOr<void> onAlimentosAdicionouAlimento(
    AlimentosAdicionouAlimento event,
    Emitter<AlimentosState> emit,
  ) async {
    emit(AlimentosAdicionandoAlimentoEmProgresso(
      state.alimentos,
      event.alimento,
    ));

    try {
      await _alimentosCliente.addAlimento(event.alimento);

      emit(AlimentosAdicionandoAlimentoSucesso(
        state.alimentos,
        event.alimento,
      ));
    } catch (e) {
      emit(AlimentosAdicionandoAlimentoFalha(
        state.alimentos,
        e.toString().toExceptionMsg(),
        event.alimento,
      ));
    }
  }

  FutureOr<void> onAlimentosRemoveuAlimento(
    AlimentosRemoveuAlimento event,
    Emitter<AlimentosState> emit,
  ) async {
    emit(AlimentosRemovendoAlimentoEmProgresso(
      state.alimentos,
      event.alimento,
    ));

    try {
      final List<Alimento> alimentos = state.alimentos;
      await _alimentosCliente.deleteAlimento(event.alimento.id!);
      alimentos.remove(event.alimento);

      emit(
        AlimentosRemovendoAlimentoSucesso(
          alimentos,
          event.alimento,
        ),
      );
    } catch (e) {
      emit(AlimentosRemovendoAlimentoFalha(
        state.alimentos,
        e.toString().toExceptionMsg(),
        event.alimento,
      ));
    }
  }
}
