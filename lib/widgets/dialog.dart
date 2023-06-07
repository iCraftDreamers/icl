import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogConfirmButton extends StatelessWidget {
  const DialogConfirmButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
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

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({
    super.key,
    this.title,
    this.content,
    this.onConfirmed,
    this.onCanceled,
  });

  final Widget? title;
  final Widget? content;
  final void Function()? onConfirmed;
  final void Function()? onCanceled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headlineSmall;
    return AlertDialog(
      titleTextStyle: textTheme!.copyWith(fontWeight: FontWeight.bold),
      title: title,
      content: content,
      actions: [
        DialogCancelButton(onPressed: onCanceled),
        DialogConfirmButton(onPressed: onConfirmed),
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
  });

  final Widget? title;
  final Widget? content;
  final void Function()? onConfirmed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Row(children: [
        Icon(
          Icons.error_outline,
          size: 36,
          color: Colors.red[400],
        ),
        const SizedBox(width: 10),
        content ?? const SizedBox(),
      ]),
      actions: [
        DialogConfirmButton(onPressed: onConfirmed),
      ],
    );
  }
}

void dialogPop() {
  Navigator.of(Get.context!).pop();
}
