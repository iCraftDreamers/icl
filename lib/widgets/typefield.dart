import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    const borderRadius = BorderRadius.all(Radius.circular(7.5));
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      validator: validator,
      readOnly: readOnly,
      maxLength: 30,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[\u4e00-\u9fa5_a-zA-Z]")),
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: const OutlineInputBorder(borderRadius: borderRadius),
        counterText: "",
        enabledBorder: const OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class TitleTextFormFiled extends MyTextFormField {
  const TitleTextFormFiled({
    super.key,
    this.titleWidth,
    required this.titleText,
    super.textEditingController,
    super.validator,
    super.labelText,
    super.hintText,
    required super.readOnly,
    required super.obscureText,
  });

  final double? titleWidth;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(titleText),
        ),
        Expanded(
          child: super.build(context),
        )
      ],
    );
  }
}
