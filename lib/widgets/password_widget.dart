import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles.dart';

class PasswordWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String label;
  final List<TextInputFormatter> inputFormatters;

  const PasswordWidget({
    Key key,
    this.textInputType,
    this.hint,
    this.controller,
    this.validator,
    this.label,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            maxLines: 1,
            style: Styles.inputTextDefaultTextStyle,
            obscureText: !_passwordVisible,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Styles.colorPrimary,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              filled: true,
              fillColor: Styles.inputTextDefaultBackgroundColor,
              hintText: widget.hint,
              hintStyle: Styles.inputTextHintDefaultTextStyle,
              contentPadding: const EdgeInsets.only(
                  left: 14.0, bottom: 8.0, top: 8.0, right: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Styles.inputTextDefaultFocusBorderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Styles.inputTextDefaultBorderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Styles.colorDanger),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
      /*
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        maxLines: 1,
        style: Styles.inputTextDefaultTextStyle,
        obscureText: !_passwordVisible,
        validator: widget.validator,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Styles.colorPrimary,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          filled: true,
          fillColor: Styles.inputTextDefaultBackgroundColor,
          hintText: widget.hint,
          hintStyle: Styles.inputTextHintDefaultTextStyle,
          contentPadding: const EdgeInsets.only(
              left: 14.0, bottom: 8.0, top: 8.0, right: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Styles.inputTextDefaultFocusBorderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.inputTextDefaultBorderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.colorDanger),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),

       */
    );
  }
}

/*
class PasswordWidget extends StatelessWidget {

  final TextInputType textInputType;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const PasswordWidget({
    Key key,
    this.textInputType,
    this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ,
        maxLines: 1,
        style: Styles.inputTextDefaultTextStyle,
        obscureText: true,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.visibility),
          filled: true,
          fillColor: Styles.inputTextDefaultBackgroundColor,
          hintText: hintText,
          hintStyle: Styles.inputTextHintDefaultTextStyle,
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0, right: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.inputTextDefaultFocusBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.inputTextDefaultBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.colorDanger),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

 */
