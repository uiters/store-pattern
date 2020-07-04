import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageController {
  static final imagePicker = ImagePicker();

  static Future<File> getImageFromGallery() {
    return imagePicker.getImage(source: ImageSource.gallery).then((value) => File(value.path));
  }

  static Future<File> getImageFromCamera() {
    return imagePicker.getImage(source: ImageSource.camera).then((value) => File(value.path));
  }
}
