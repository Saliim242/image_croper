import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper(
      {required ImagePicker? imagePicker, required ImageCropper? imageCropper})
      : _imagerPicker = imagePicker ?? ImagePicker(),
        _imageCrope = imageCropper ?? ImageCropper();

  final ImagePicker _imagerPicker;
  final ImageCropper _imageCrope;

  // Singe Picker Iamge From The User
  Future<List<XFile?>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuelity = 100,
    bool multiImage = false,
  }) async {
    if (multiImage) {
      return await _imagerPicker.pickMultiImage(imageQuality: imageQuelity);
    }

    final file = await _imagerPicker.pickImage(
      source: source,
      imageQuality: imageQuelity,
    );

    if (file != null) return [file];

    return [];
  }

  // Crope The Image Picked The User

  Future<CroppedFile?> cropeImage(
      {required XFile file, CropStyle cropStyle = CropStyle.rectangle}) async {
    return await _imageCrope.cropImage(
      sourcePath: file.path,
      cropStyle: cropStyle,
      compressQuality: 100,
      uiSettings: [],
    );
  }
}
