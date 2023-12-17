import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Shows a basic snackbar with provided text.
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

// Asynchronously picks multiple images and returns them as a File list.
Future<List<File>> pickImages() async {
  // An empty list to hold image files.
  List<File> images = [];
  // Pick and add multiple images to list (null check & empty check)
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    // Adding selected files to images list.
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    // Print exception details for debugging
    debugPrint(e.toString());
  }
  // Returns a list of loaded images
  return images;
}
