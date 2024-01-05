import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.textEditingController,
    required this.hintText,
    required this.validator,
    this.readOnly = false,
    this.isLinkField = false,
    this.onChanged,
    super.key,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool isLinkField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      style: isLinkField
          ? const TextStyle(
              color: Colors.blue,
            )
          : null,
    );
  }
}
