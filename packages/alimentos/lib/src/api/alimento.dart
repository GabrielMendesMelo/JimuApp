class Alimento {
  final String nome;
  final String? id;
  // final Valor calorias;
  // final Valor carboidratos;
  // final Valor proteinas;
  // final Valor gordurasTotais;
  // final Valor gordurasSaturadas;
  // final Valor sodio;
  // final Valor fibraAlimentar;

  const Alimento({
    required this.nome,
    this.id,
    // required this.calorias,
    // required this.carboidratos,
    // required this.proteinas,
    // required this.gordurasTotais,
    // required this.gordurasSaturadas,
    // required this.sodio,
    // required this.fibraAlimentar,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      nome: json['nome'],
      id: json['id'],
      // calorias: Valor.fromJson(json['calorias']),
      // carboidratos: Valor.fromJson(json['carboidratos']),
      // proteinas: Valor.fromJson(json['proteinas']),
      // gordurasTotais: Valor.fromJson(json['gorduras_totais']),
      // gordurasSaturadas: Valor.fromJson(json['gorduras_saturadas']),
      // sodio: Valor.fromJson(json['sodio']),
      // fibraAlimentar: Valor.fromJson(json['fibra_alimentar']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      // 'calorias': calorias,
      // 'carboidratos': carboidratos,
      // 'proteinas': proteinas,
      // 'gorduras_totais': gordurasTotais,
      // 'gorduras_saturadas': gordurasSaturadas,
      // 'sodio': sodio,
      // 'fibra_alimentar': fibraAlimentar,
    };
  }
}
