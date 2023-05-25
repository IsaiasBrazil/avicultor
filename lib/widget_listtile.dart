import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String nome;
  final IconData? icone;
  final VoidCallback? onTap;
  final TextAlign? alinhamentoDoTexto;
  const ListTileCustom({super.key, required this.nome, this.icone, this.onTap, this.alinhamentoDoTexto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: icone != null ? Icon(icone) : null,
        title: Text(nome,
            style: TextStyle(
                fontFamily: 'BebasNeue', fontSize: 26, color: Colors.white), textAlign: alinhamentoDoTexto),
        onTap: onTap);
  }
}
