import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone_validator/styles/text_styles.dart';

class OwnTextField extends StatefulWidget {
  const OwnTextField(
      {key,
      this.hintTextTextField = '',
      this.prefixIcon,
      this.editingText,
      this.textFieldType,
      this.hasFormater = false});

  final String hintTextTextField;
  final TextInputType textFieldType;
  final bool hasFormater;
  final Icon prefixIcon;
  final Function(String) editingText;
  @override
  State<OwnTextField> createState() => _OwnTextFieldState();
}

class _OwnTextFieldState extends State<OwnTextField> {
  final controller = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 15),
      child: SizedBox(
        height: 48,
        child: TextField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) {
            widget.editingText(controller.text);
          },
          cursorColor: const Color.fromRGBO(87, 77, 113, 1),
          style: Styles.codeCoutryFont,
          controller: controller,
          keyboardType: widget.textFieldType,
          inputFormatters: widget.hasFormater ? [maskFormatter] : [],
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintStyle: const TextStyle(),
            hintText: widget.hintTextTextField,
            prefixIcon: widget.prefixIcon,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                color: Color.fromRGBO(244, 245, 255, 0.4),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                color: Color.fromRGBO(244, 245, 255, 0.4),
                // width: 0,
              ),
            ),
            filled: true,
            fillColor: const Color.fromRGBO(244, 245, 255, 0.4),
          ),
        ),
      ),
    );
  }
}
