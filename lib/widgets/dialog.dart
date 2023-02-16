import 'package:flutter/material.dart';

class DialogConfirmButton extends StatelessWidget {
  const DialogConfirmButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(
            color: Theme.of(context).colorScheme.primary, width: 1.0)),
      ),
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
  const WarningDialog({
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
      title: Text(title ?? "", style: TextStyle(color: Colors.orange[800])),
      content: Row(
        children: [
          Icon(Icons.warning_rounded, size: 36, color: Colors.orange[800]),
          SizedBox(width: 10),
          Text(content ?? ""),
        ],
      ),
      actions: [
        DialogConfirmButton(onPressed: onConfirmed),
        DialogCancelButton(onPressed: onCanceled),
      ],
    );
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
        style: TextStyle(color: Colors.red[400]),
      ),
      content: Row(children: [
        Icon(
          Icons.error_outline,
          size: 36,
          color: Colors.red[400],
        ),
        SizedBox(width: 10),
        Text(content ?? "")
      ]),
      actions: [
        DialogConfirmButton(onPressed: onConfirmed),
        DialogCancelButton(onPressed: onCanceled),
      ],
    );
  }
}
