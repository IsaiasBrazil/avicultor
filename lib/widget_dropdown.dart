import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  List<String> options;
  String selectedOption;
  void  onChanged;
  Dropdown({Key? key,required this.options,required this.selectedOption, required this.onChanged}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  get onChanged => widget.onChanged;
  @override
  Widget build(BuildContext context) {
    List<String> options = widget.options;
    String selectedOption = widget.selectedOption;
    selectedOption = selectedOption.isEmpty ? options[0] : selectedOption;
    return DropdownButton<String>(
          value: selectedOption,
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                width: 157,
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
