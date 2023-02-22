import 'package:alimentos/src/api/api.dart';

abstract class AlimentosEvent {}

class AlimentosCarregouAlimentos extends AlimentosEvent {}

class AlimentosAdicionouAlimento extends AlimentosEvent {
  Alimento alimento;

  AlimentosAdicionouAlimento({
    required this.alimento,
  });
}

class AlimentosRemoveuAlimento extends AlimentosEvent {
  Alimento alimento;

  AlimentosRemoveuAlimento({
    required this.alimento,
  });
}
