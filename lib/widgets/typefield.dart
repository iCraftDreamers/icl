import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.textEditingController,
    this.validator,
    this.labelText,
    this.hintText,
    required this.readOnly,
    required this.obscureText,
  });

  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final bool obscureText;

  static String? checkEmpty(value) {
    return (value == null || value.isEmpty) ? "此处不得留空！" : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.5))),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class TitleTextFormFiled extends MyTextFormField {
  @override
  const TitleTextFormFiled(
      {super.key,
      this.titleWidth,
      required this.titelText,
      super.textEditingController,
      super.validator,
      super.labelText,
      super.hintText,
      required super.readOnly,
      required super.obscureText});

  final double? titleWidth;
  final String titelText;
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(titelText),
        ),
        Expanded(
          child: super.build(context),
        )
      ],
    );
  }
}
