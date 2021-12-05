import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String> validator;

  final Function onChanged;
  final int maxChar;
  final TextInputType textInputType;
  final int maxLines;
  final int minLines;
  final String label;
  final bool readonly;
  final bool obscureText;
  final Function onPressed;
  final Widget prefix;
  final List<TextInputFormatter> inputFormatters;
  final Function onSaved;
  final String obscuringCharacter;
  final bool enabled;

  const TextFieldWidget(
      {Key key,
      this.obscureText,
      this.hint,
      this.controller,
      this.validator,
      this.onChanged,
      this.maxChar,
      this.textInputType,
      this.maxLines,
      this.minLines,
      this.label,
      this.readonly,
      this.onPressed,
      this.prefix,
      this.inputFormatters,
      this.onSaved,
      this.enabled,
      bool scureText,
      this.obscuringCharacter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
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
            textField(),
          ],
        ));
  }

  Widget textField() {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      maxLength: maxChar ?? 10000,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? maxLines,
      style: Styles.inputTextDefaultTextStyle,
      decoration: Styles.textInputDecoration(hint: hint, prefix: prefix),
      readOnly: readonly ?? false,
      onTap: onPressed,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      enabled: enabled ?? true,
    );
  }
}
