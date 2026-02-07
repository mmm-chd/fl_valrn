
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
      print("Journals fetched: ${journals.length}");
      for (var j in journals) {
        print(" - ${j.title} | ${j.description} | image: ${j.imageUrl}");
      }
    } catch (e) {
      print('Error fetching journals: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createJournal(String title, String description, {String? imageUrl}) async {
    try {
      isLoading.value = true;
      final success = await JournalService.createJournal(
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

      if (success) {
        Get.snackbar(
          'Berhasil', 
          'Field / Journal berhasil ditambahkan',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchData(); // reload journals
      } else {
        Get.snackbar(
          'Error', 
          'Gagal menambahkan Field / Journal',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Terjadi kesalahan: $e', 
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // PERBAIKAN: Tambahkan parameter untuk menerima data dari UI
  Future<void> updateJournal(
    int id, {
    String? title,
    String? description,
    String? imageUrl,
  }) async {
    try {
      isLoading.value = true;
      final success = await JournalService.updateJournal(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

      if (success) {
        Get.snackbar(
          'Berhasil', 
          'Field / Journal berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchData(); // reload journals
      } else {
        Get.snackbar(
          'Error', 
          'Gagal memperbarui Field / Journal',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Terjadi kesalahan: $e', 
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}