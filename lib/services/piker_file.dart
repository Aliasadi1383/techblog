import 'package:file_picker/file_picker.dart';
import 'package:get/instance_manager.dart';
import 'package:tec/controller/file_controller.dart';
 FilePikerController filePikerController=Get.put(FilePikerController());

Future pikerFile()async{

  FilePickerResult? result=await FilePicker.platform.pickFiles(type: FileType.image);
  filePikerController.file.value=result!.files.first;
}