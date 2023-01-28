import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File> filePicker([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions ?? ['*'],
    lockParentWindow: true,
  );
  if (result == null) return File("");

  File file = File(result.files.single.path.toString());
  return file;
}

Future<File> folderPicker() async {
  String? selectedDirectory =
      await FilePicker.platform.getDirectoryPath(lockParentWindow: true);
  if (selectedDirectory == null) File("");

  File file = File(selectedDirectory!);
  return file;
}
