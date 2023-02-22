import 'package:alimentos/src/api/alimento.dart';
import 'package:compartilhado/compartilhado.dart';

class AlimentosCliente extends Cliente {
  static const String _alimentos = 'alimentos';

  AlimentosCliente()
      : super(
          pathBase: '$_alimentos/',
        );

  Future<List<Alimento>> getAlimentos() async {
    final response = await get();
    final List<Alimento> alimentos = <Alimento>[];
    for (final dynamic a in response) {
      alimentos.add(
        Alimento.fromJson(a),
      );
    }
    return alimentos;
  }

  Future<Alimento> addAlimento(Alimento alimento) async {
    await post(
      body: alimento.toJson(),
    );

    return alimento;
  }

  Future<void> deleteAlimento(String id) async {
    await delete(urn: id);
  }
}
