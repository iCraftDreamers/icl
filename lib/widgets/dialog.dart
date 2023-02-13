import 'package:flutter/material.dart';

class DialogConfirmButton extends StatelessWidget {
  const DialogConfirmButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: const Text("确定", style: TextStyle(fontSize: 16)),
    );
  }
}

class DialogCancelButton extends StatelessWidget {
  const DialogCancelButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text("取消", style: TextStyle(fontSize: 16)),
    );
  }
}

class WarningDialog extends StatelessWidget {
  const WarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    this.content,
    this.onConfirmed,
    this.onCanceled,
  });

  final String? title;
  final String? content;
  final void Function()? onConfirmed;
  final void Function()? onCanceled;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? "",
        style: TextStyle(
          color: Color.fromARGB(238, 248, 97, 95),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content ?? ""),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 255, 117, 117),
          ),
          onPressed: onConfirmed,
          child: const Text("确定", style: TextStyle(fontSize: 16)),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 39, 35, 35),
          ),
          onPressed: onCanceled,
          child: const Text("取消", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
