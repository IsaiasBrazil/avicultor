class Producao {
  final String codigo;
  final String codigoLote;
  final int quantidadeAves;
  final double peso;
  final String data;
  final String? observacao;

  const Producao(
      {required this.codigo,
      required this.codigoLote,
      required this.quantidadeAves,
      required this.peso,
      required this.data,
      this.observacao});

  @override
  String toString() {
    return 'Producao{codigo: $codigo, codigoLote: $codigoLote, quantidadeAves: $quantidadeAves, peso: $peso, data: $data, observacao: $observacao}';
  }

  factory Producao.fromMap(Map<String, dynamic> json) => Producao(
      codigo: json['codigo'],
      codigoLote: json['fk_cod_lote'],
      quantidadeAves: json['quantidade_aves'],
      peso: json['peso'],
      data: json['data'],
      observacao: json['observacao']);

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'fk_cod_lote': codigoLote,
      'quantidade_aves': quantidadeAves,
      'peso': peso,
      'data': data,
      'observacao': observacao
    };
  }
}
