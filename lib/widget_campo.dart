import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Campo extends StatefulWidget {
  final String nome;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  const Campo(
      {super.key,
      required this.nome,
      required this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.onTap});

  @override
  State<Campo> createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.nome,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'BebasNeue',
            ),
          ),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
