class Galpao {
  final int codigo;
  final String descricao;

  const Galpao({required this.codigo, required this.descricao});

  @override
  String toString() {
    return 'Galpao{codigo: $codigo, descricao: $descricao}';
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
    };
  }
}