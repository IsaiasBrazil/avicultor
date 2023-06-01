class Lote {
  final String codigoLote;
  final String? codigoGalpao;
  final int? idade;
  final String? dataChegada;
  final String? descricao;

  const Lote({required this.codigoLote, this.codigoGalpao, this.idade, this.dataChegada, this.descricao});

  @override
  String toString() {
    return 'Lote{codigoLote: $codigoLote, codigoGalpao: $codigoGalpao, idade: $idade, dataChegada: $dataChegada, descricao: $descricao}';
  }

  factory Lote.fromMap(Map<String, dynamic> json) =>
      Lote(
        codigoLote: json['codigo'], 
        codigoGalpao: json['fk_cod_galpao'],
        idade: json['idade'],
        dataChegada: json['data_chegada'],
        descricao: json['descricao']);

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigoLote,
      'descricao': descricao,
      'idade': idade,
      'data_chegada': dataChegada,
      'fk_cod_galpao': codigoGalpao
    };
  }
}
