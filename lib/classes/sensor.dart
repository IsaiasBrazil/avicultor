class Sensor {
  final String? codigo;
  final String codigoGalpao;
  final String? tipo;
  final String? descricao;

  const Sensor({this.codigo, required this.codigoGalpao, this.tipo, this.descricao});

  @override
  String toString() {
    return 'Sensor{Código: $codigo, Código do Galpão: $codigoGalpao, tipo: $tipo, descricao: $descricao}';
  }

  factory Sensor.fromMap(Map<String, dynamic> json) =>
      Sensor(
        codigo: json['codigo'],
        descricao: json['descricao'], 
        codigoGalpao: json['fk_cod_galpao'],
        tipo: json['tipo']
        );

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'fk_cod_galpao': codigoGalpao,
      'tipo': tipo
    };
  }
}
