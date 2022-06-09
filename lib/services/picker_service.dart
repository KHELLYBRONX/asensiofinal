import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickerService{
  static final instance = PickerService._();
  late final ImagePicker _imagePicker;
  // late final ImagePicker _filePicker;
  
  PickerService._(){
    _imagePicker = ImagePicker();
  }


  Future<Uint8List?> pickImage(ImageSource source)async{
    var res = await _imagePicker.pickImage(source:source);
    if(res == null)return null;
    return await res.readAsBytes();
  }


  Future showDialogForImage()async{}

  Future<FilePickerResult?> pickDocument()async{
    var file = FilePicker.platform.pickFiles();
    return file;
  }

}