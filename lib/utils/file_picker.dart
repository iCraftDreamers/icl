import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> filePicker([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions ?? ['*'],
    lockParentWindow: true,
  );

  File file =
      result == null ? File("") : File(result.files.single.path.toString());
  return file;
}

Future<File?> folderPicker() async {
  String? selectedDirectory =
      await FilePicker.platform.getDirectoryPath(lockParentWindow: true);

  File file = File(selectedDirectory ?? "");
  return file;
}
