class Galpao {
  final String codigo;
  final String? descricao;

  const Galpao({required this.codigo, this.descricao});

  @override
  String toString() {
    return 'Galpao{codigo: $codigo, descricao: $descricao}';
  }

  factory Galpao.fromMap(Map<String, dynamic> json) =>
      Galpao(codigo: json['codigo'], descricao: json['descricao']);

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
    };
  }
}
