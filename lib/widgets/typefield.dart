import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.maxLines,
    this.maxLength,
    this.obscureText,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;

  static String? checkEmpty(value) {
    return (value == null || value.isEmpty) ? "此处不得留空！" : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(borderRadius: kBorderRadius),
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class TitleTextFormFiled extends DefaultTextFormField {
  const TitleTextFormFiled({
    super.key,
    super.controller,
    super.validator,
    super.labelText,
    super.hintText,
    super.maxLines,
    super.maxLength,
    super.inputFormatters,
    required super.readOnly,
    required super.obscureText,
    this.titleWidth,
    required this.titleText,
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
