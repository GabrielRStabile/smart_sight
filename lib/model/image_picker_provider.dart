import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  final ImagePicker picker = ImagePicker();

  Future<String?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }
}
