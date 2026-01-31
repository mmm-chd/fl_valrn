import 'package:fl_valrn/model/journal_model.dart';
import 'package:get/get.dart';
import '../services/journal_service.dart';

class JournalController extends GetxController {
  var journals = <Journal>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      journals.value = await JournalService.fetchJournals();
    } catch (e) {
      print('Error fetching journals: $e');
    } finally {
      isLoading.value = false;
    }
  }
}