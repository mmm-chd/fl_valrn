import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddproductController extends GetxController{
  final TextEditingController productNamec= TextEditingController();
  final picker = ImagePicker();

  final images = <XFile>[].obs;

  void addImage(XFile image){
    images.add(image);
  }

  void removeImage(int index){
    images.removeAt(index);
  }

  Future<void> pickImage() async{
    final image= await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      addImage(image);
    }
  }
}