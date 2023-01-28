import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.lable,
    required this.hintText,
    required this.controller,
    this.onPressed,
  });

  final IconData icon;
  final String lable;
  final String hintText;
  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed ?? () {},
          icon: Icon(icon),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            height: 42,
            child: TextField(
              controller: controller,
              cursorHeight: 20,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                ),
                hintText: hintText,
                label: Text(lable),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
