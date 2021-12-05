import 'package:flutter/material.dart';

import '../styles.dart';

class DropdownWidget extends StatelessWidget {
  final int selectedIdx;
  final Function(dynamic selectedValue) callback;
  final List options;
  final String hint;
  final String label;
  final FormFieldValidator<String> validator;

  const DropdownWidget({
    Key key,
    this.selectedIdx,
    this.callback,
    this.options,
    this.hint,
    this.label,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null)
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            DropdownButtonFormField(
              hint: Text(hint),
              //value: options[selectedIdx],
              items: options.map((item) {
                return DropdownMenuItem(
                  child: Text(item['name']),
                  value: item['id'],
                );
              }).toList(),
              onChanged: (selectedValue) {
                callback(selectedValue);
              },
              decoration: Styles.textInputDecoration(hint: hint),
            ),
          ],
        ));
  }
}
