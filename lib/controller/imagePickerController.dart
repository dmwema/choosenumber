
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  final _image = Rxn<File>();

  Future<File?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      Get.snackbar(
          'Image', 'Image has been successfully selected!');
    }
    _image.value = File(pickedImage!.path);
    return _image.value;
  }
  Future<String> imageB64(File file) async{
    List<int> imageBytes = file.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}