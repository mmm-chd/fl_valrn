import 'package:fl_valrn/services/analyses_service.dart';
import 'package:get/get.dart';

class AnalysisController extends GetxController {
  var isLoading = false.obs;

  /// Method untuk create analysis dengan data hardcoded seperti di gambar Postman
  Future<void> createAnalysis(int journalId) async {
    try {
      isLoading.value = true;

      // Data sesuai dengan screenshot Postman Anda
      final success = await AnalysisService.createAnalysis(
        analyzeJournalId: journalId, // ID journal yang dipilih user
        images: [
          "analyses/image1.jpg",
          "analyses/image2.jpg"
        ],
        plantCommonName: "Tomato",
        plantScientificName: "Solanum lycopersicum",
        healthStatus: "Healthy",
        healthConfidence: 0.95,
        healthUrgency: "Low",
        diagnosis: "Plant looks healthy",
        recommendations: [
          "Continue regular watering",
          "Monitor for pests"
        ],
      );

      if (success) {
        Get.snackbar(
          'Berhasil',
          'Analysis berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Gagal membuat analysis',
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

  /// Method dengan parameter lengkap (jika nanti mau dinamis)
  Future<void> createAnalysisDynamic({
    required int journalId,
    required List<String> images,
    required String plantCommonName,
    required String plantScientificName,
    required String healthStatus,
    required double healthConfidence,
    required String healthUrgency,
    required String diagnosis,
    required List<String> recommendations,
  }) async {
    try {
      isLoading.value = true;

      final success = await AnalysisService.createAnalysis(
        analyzeJournalId: journalId,
        images: images,
        plantCommonName: plantCommonName,
        plantScientificName: plantScientificName,
        healthStatus: healthStatus,
        healthConfidence: healthConfidence,
        healthUrgency: healthUrgency,
        diagnosis: diagnosis,
        recommendations: recommendations,
      );

      if (success) {
        Get.snackbar(
          'Berhasil',
          'Analysis berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Gagal membuat analysis',
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