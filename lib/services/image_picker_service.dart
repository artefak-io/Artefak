import 'package:image_picker/image_picker.dart';

// pretty useless class for now because the imagepicker method could be used
// directly in the update profile screen
class ImagePickerService {
  static final _imagepickerservice = ImagePickerService._();

  ImagePickerService._();

  factory ImagePickerService() {
    return _imagepickerservice;
  }

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return null;
    } else if (response.file != null) {
      return response.file;
    } else {
      print(response.exception!.message);
      return null;
    }
  }

  Future<XFile?> retrieveImage() async {
    return _picker.pickImage(source: ImageSource.gallery);
  }
}
