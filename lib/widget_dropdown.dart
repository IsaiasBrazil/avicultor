import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> opcoes;
  final String? itemSelecionado;
  final double tamanhoIcone;
  final ValueChanged<String?> aoSerSelecionado;

  const Dropdown(
      {super.key,
      required this.opcoes,
      required this.itemSelecionado,
      required this.tamanhoIcone,
      required this.aoSerSelecionado});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      iconSize: widget.tamanhoIcone,
      value: widget.itemSelecionado ?? widget.opcoes.first,
      items: widget.opcoes
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 20.0)),
              ))
          .toList(),
      onChanged: widget.aoSerSelecionado,
    );
  }
}