import 'package:fl_valrn/dummy_data/dummyFields.dart';
import 'package:fl_valrn/dummy_data/dummyRecent.dart';
import 'package:fl_valrn/model/fields_model.dart';
import 'package:fl_valrn/model/recent_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FieldsController extends GetxController {
  final searchController= TextEditingController();

  var fieldsCard = <FieldsItem>[].obs;
  var recentCard = <RecentItems>[].obs;
  var isLoading= true.obs;
  
  @override
  void onInit() {
    // TODO: implement onInit
    fetchFields();
    fetchRecents();
    super.onInit();
  }
  void fetchFields() async {
    await Future.delayed(Duration(seconds: 2));
    fieldsCard.value = dummyField;
    isLoading.value = false;
  }
  void fetchRecents() async {
    await Future.delayed(Duration(seconds: 2));
    recentCard.value = dummyRecent;
    isLoading.value = false;
  }
}