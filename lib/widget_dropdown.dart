import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  List<String> options;
  Dropdown({Key? key,required this.options}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String selectedOption="";
  @override
  Widget build(BuildContext context) {
    List<String> options = widget.options;

    selectedOption = selectedOption.isEmpty? options[0]:selectedOption;
    return DropdownButton<String>(
          value: selectedOption,
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                width: 420,
                  child: Text(style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'BebasNeue',),
                      value)
              ),
            );
          }).toList(),
        );
  }
}
