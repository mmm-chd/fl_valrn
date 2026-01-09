import 'package:get/get.dart';
import '../dummy_data/dummyOverview.dart';

class OverviewController extends GetxController {
  // Tab index (0 = Penyakit, 1 = Deteksi)
  var currentTabIndex = 0.obs;
  var isLoading = false.obs;

  // Plant basic info
  var plantName = ''.obs;
  var scientificName = ''.obs;
  
  // Disease tab data
  var diseaseTitle = ''.obs;
  var diseaseDescription = ''.obs;
  var symptoms = <String>[].obs;
  var causes = <String>[].obs;
  var impact = <String>[].obs;
  var prevention = <String>[].obs;

  // Detection tab data (Deteksi & Habitat)
  var nutritionData = <String, String>{}.obs;
  var descriptionText = ''.obs;
  var habitatTitle = ''.obs;
  var habitatText = ''.obs;
  var advantages = <String>[].obs;
  var disadvantages = <String>[].obs;
  var cultivation = <String>[].obs;
  var funFact = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get data from arguments (from API result)
    loadDataFromApi();
  }

  // Switch tab
  void selectTab(int index) {
    currentTabIndex.value = index;
  }

  // Load data dari API result yang dikirim dari halaman sebelumnya
  void loadDataFromApi() {
    // Get data dari Get.arguments (dari API AI detection)
    var apiData = Get.arguments ?? DummyOverviewData.getData();
    var analysis = apiData['analysis'] ?? {};
    
    // === IDENTIFICATION ===
    var identification = analysis['identification'] ?? {};
    plantName.value = identification['common_name'] ?? '';
    scientificName.value = identification['scientific_name'] ?? '';
    descriptionText.value = identification['short_description'] ?? '';
    
    // === HEALTH STATUS ===
    var health = analysis['health'] ?? {};
    String healthStatus = health['status'] ?? 'safe';
    
    // Jika tanaman SAKIT (has disease)
    if (healthStatus != 'safe' && health['diseases'] != null && (health['diseases'] as List).isNotEmpty) {
      var diseases = health['diseases'] as List;
      var firstDisease = diseases[0];
      
      diseaseTitle.value = firstDisease['name'] ?? 'Penyakit Terdeteksi';
      diseaseDescription.value = health['summary'] ?? '';
      symptoms.value = List<String>.from(health['symptoms'] ?? []);
      
      // Impact dari action plan
      var actionPlan = health['action_plan'] ?? {};
      impact.value = List<String>.from(actionPlan['short_term'] ?? []);
      prevention.value = List<String>.from(health['recommended_actions'] ?? []);
      
      // Causes (bisa dari pests atau diseases)
      causes.value = [];
      if (health['pests'] != null) {
        causes.addAll(List<String>.from(health['pests']));
      }
    } else {
      // Jika tanaman SEHAT
      diseaseTitle.value = 'Tanaman Sehat';
      diseaseDescription.value = health['summary'] ?? 'Tanaman dalam kondisi sehat';
      symptoms.value = [];
      causes.value = [];
      impact.value = [];
      prevention.value = List<String>.from(health['recommended_actions'] ?? []);
    }
    
    // === NUTRITIONAL VALUE ===
    var nutritionalValue = analysis['nutritional_value'] ?? {};
    var nutrients = nutritionalValue['nutrients_per_100g'] ?? {};
    
    // Format nutrition data untuk InfoRow
    nutritionData.value = {
      'Kandungan: ${nutrients['energy'] ?? '-'}': '',
      'Karbohidrat: ${nutrients['carbohydrates'] ?? '-'}': 'Protein: ${nutrients['protein'] ?? '-'}',
      'Serat: ${nutrients['fiber'] ?? '-'}': 'Lemak: ${nutrients['fat'] ?? '-'}',
    };
    
    // Tambahkan vitamins
    var vitamins = nutritionalValue['vitamins'] as List? ?? [];
    if (vitamins.isNotEmpty) {
      nutritionData['Vitamin:'] = vitamins.take(3).join(', ');
    }
    
    // Tambahkan minerals
    var minerals = nutritionalValue['minerals'] as List? ?? [];
    if (minerals.isNotEmpty) {
      nutritionData['Mineral:'] = minerals.take(3).join(', ');
    }
    
    // === GROWTH REQUIREMENTS (HABITAT) ===
    var growthReq = analysis['growth_requirements'] ?? {};
    habitatTitle.value = 'Habitat & Distribusi';
    habitatText.value = 
        'Tanaman ini membutuhkan ${growthReq['soil_type'] ?? 'tanah yang baik'} dengan pH ${growthReq['ph_range'] ?? '6.0-7.0'}. '
        'Suhu ideal: ${growthReq['temperature_range_number'] ?? '20-30°C'}. '
        '${growthReq['lighting'] ?? 'Membutuhkan cahaya matahari yang cukup'}. '
        '${growthReq['watering'] ?? 'Penyiraman teratur diperlukan'}.';
    
    // === USES (KEUNGGULAN) ===
    var uses = analysis['uses'] ?? {};
    advantages.value = [];
    
    if (uses['culinary'] != null && uses['culinary'] != '') {
      advantages.add('Kuliner: ${uses['culinary']}');
    }
    if (uses['medicinal'] != null && uses['medicinal'] != '') {
      advantages.add('Medis: ${uses['medicinal']}');
    }
    if (uses['industrial'] != null && uses['industrial'] != '') {
      advantages.add('Industri: ${uses['industrial']}');
    }
    
    // Health benefits dari nutritional value
    var healthBenefits = nutritionalValue['health_benefits'] as List? ?? [];
    if (healthBenefits.isNotEmpty) {
      advantages.add('Manfaat Kesehatan:');
      advantages.addAll(healthBenefits.map((e) => '• $e').toList());
    }
    
    // === RISKS (KEKURANGAN) ===
    var additionalInfo = analysis['additional_info'] ?? {};
    disadvantages.value = [];
    
    if (additionalInfo['risks'] != null && additionalInfo['risks'] != '') {
      disadvantages.add('Risiko: ${additionalInfo['risks']}');
    }
    if (additionalInfo['toxic_parts'] != null && additionalInfo['toxic_parts'] != '') {
      disadvantages.add('Bagian Beracun: ${additionalInfo['toxic_parts']}');
    }
    
    // Dietary notes
    var dietaryNotes = nutritionalValue['dietary_notes'] as List? ?? [];
    if (dietaryNotes.isNotEmpty) {
      disadvantages.add('Catatan Diet: ${dietaryNotes.join(', ')}');
    }
    
    // === CARE INSTRUCTIONS (BUDIDAYA) ===
    var careInstructions = analysis['care_instructions'] ?? {};
    cultivation.value = [];
    
    if (careInstructions['watering'] != null) {
      cultivation.add('Penyiraman: ${careInstructions['watering']}');
    }
    if (careInstructions['fertilization'] != null) {
      cultivation.add('Pemupukan: ${careInstructions['fertilization']}');
    }
    if (careInstructions['other_maintenance'] != null) {
      cultivation.add('Perawatan Lain: ${careInstructions['other_maintenance']}');
    }
    if (growthReq['planting_season'] != null) {
      cultivation.add('Musim Tanam: ${growthReq['planting_season']}');
    }
    if (growthReq['harvest_time'] != null) {
      cultivation.add('Waktu Panen: ${growthReq['harvest_time']}');
    }
    
    // === FUN FACT ===
    funFact.value = additionalInfo['native_habitat'] != null 
        ? 'Habitat Asli: ${additionalInfo['native_habitat']}'
        : 'Tanaman ini memiliki keunikan tersendiri dalam ekosistem.';
  }

  // Save to journal
  void saveToJournal() {
    // Implement save to journal functionality
    Get.snackbar(
      'Tersimpan',
      'Data berhasil disimpan ke jurnal',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}