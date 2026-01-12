import 'package:get/get.dart';

class OverviewController extends GetxController {
  var currentTabIndex = 0.obs;

  void selectTab(int index) {
    currentTabIndex.value = index;
  }

  var plantName = ''.obs;
  var scientificName = ''.obs;
  var descriptionText = ''.obs;

  var images = <String>[].obs;

  var diseaseTitle = ''.obs;
  var diseaseDescription = ''.obs;
  var symptoms = <String>[].obs;
  var causes = <String>[].obs;
  var impact = <String>[].obs;
  var prevention = <String>[].obs;
  var isHealthy = true.obs;

  var nutritionData = <String, String>{}.obs;
  var habitatTitle = ''.obs;
  var habitatText = ''.obs;
  var advantages = <String>[].obs;
  var disadvantages = <String>[].obs;
  var cultivation = <String>[].obs;
  var funFact = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataFromApi();
  }

  void loadDataFromApi() {
    final apiData = Get.arguments ?? {};

    print('=== RECEIVED API DATA ===');
    print(apiData);
    print('========================');

    final data = apiData['data'] ?? {};
    final analysis = data['analysis'] ?? apiData['analysis'] ?? {};

    images.clear();
    if (apiData['imagePath'] != null) {
      images.add(apiData['imagePath']);
    }

    final identification = analysis['identification'] ?? {};
    plantName.value = identification['common_name'] ?? 'Unknown Plant';
    scientificName.value = identification['scientific_name'] ?? '';
    descriptionText.value = identification['short_description'] ?? '';

    final health = analysis['health'] ?? {};
    final healthStatus = health['status'] ?? 'safe';
    
    isHealthy.value = healthStatus == 'safe';

    if (isHealthy.value) {
      diseaseTitle.value = 'Tanaman Anda Sehat!';
      diseaseDescription.value = health['summary'] ?? 
          'Tanaman dalam kondisi baik. Tidak ada penyakit atau hama yang terdeteksi.';
      
      symptoms.value = [];
      causes.value = [];
      impact.value = [];

      prevention.value = (health['recommended_actions'] is List)
          ? List<String>.from(health['recommended_actions'])
          : [
              'Lanjutkan perawatan rutin',
              'Pantau kondisi tanaman secara berkala',
              'Jaga kebersihan area tanam',
            ];
    } else {
      final diseases = health['diseases'] ?? [];
      
      if (diseases is List && diseases.isNotEmpty) {
        final firstDisease = diseases.first;
        
        // Disease Title
        diseaseTitle.value = firstDisease['name'] ?? 'Penyakit Terdeteksi';
        
        // Disease Description
        diseaseDescription.value = health['summary'] ?? 
            firstDisease['impact'] ?? 
            'Tanaman mengalami gangguan kesehatan.';
        
        // Symptoms
        symptoms.value = (health['symptoms'] is List)
            ? List<String>.from(health['symptoms'])
            : (firstDisease['symptoms'] is List)
                ? List<String>.from(firstDisease['symptoms'])
                : [];
        
        // Causes
        causes.value = (firstDisease['causes'] is List)
            ? List<String>.from(firstDisease['causes'])
            : [];
        
        // Impact
        final estimatedImpact = firstDisease['estimated_impact'] ?? {};
        impact.value = [];
        
        if (estimatedImpact['yield_loss_percent'] != null) {
          impact.add('Potensi kehilangan hasil: ${estimatedImpact['yield_loss_percent']}');
        }
        if (firstDisease['impact'] != null) {
          impact.add(firstDisease['impact']);
        }
        
        if (impact.isEmpty) {
          final actionPlan = health['action_plan'] ?? {};
          if (actionPlan['short_term'] is List) {
            impact.value = List<String>.from(actionPlan['short_term']);
          }
        }
        
        // Prevention
        prevention.value = [];
        
        final controlMeasures = firstDisease['control_measures'] ?? {};
        final preventiveMeasures = controlMeasures['preventive'] ?? [];
        final curativeMeasures = controlMeasures['curative'] ?? [];
        
        if (preventiveMeasures is List) {
          prevention.addAll(List<String>.from(preventiveMeasures));
        }
        if (curativeMeasures is List) {
          prevention.addAll(List<String>.from(curativeMeasures));
        }
        
        // Recommended_actions
        if (health['recommended_actions'] is List) {
          prevention.addAll(List<String>.from(health['recommended_actions']));
        }
        
        // Remove duplicates
        prevention.value = prevention.toSet().toList();
      } else {
        diseaseTitle.value = 'Peringatan Kesehatan';
        diseaseDescription.value = health['summary'] ?? health['message'] ?? '';
        symptoms.value = (health['symptoms'] is List)
            ? List<String>.from(health['symptoms'])
            : [];
        causes.value = [];
        impact.value = [];
        prevention.value = (health['recommended_actions'] is List)
            ? List<String>.from(health['recommended_actions'])
            : [];
      }
    }

    nutritionData.clear();
    final nutrition = analysis['nutritional_value'] ?? {};
    final nutrients = nutrition['nutrients_per_100g'] ?? {};

    nutritionData.addAll({
      'Kandungan: ${nutrients['energy'] ?? '-'}': '',
      'Karbohidrat: ${nutrients['carbohydrates'] ?? '-'}': 'Protein: ${nutrients['protein'] ?? '-'}',
      'Serat: ${nutrients['fiber'] ?? '-'}': 'Lemak: ${nutrients['fat'] ?? '-'}',
    });

    if (nutrition['vitamins'] is List) {
      final vitamins = (nutrition['vitamins'] as List).take(3).join(', ');
      if (vitamins.isNotEmpty) {
        nutritionData['Vitamin:'] = vitamins;
      }
    }

    if (nutrition['minerals'] is List) {
      final minerals = (nutrition['minerals'] as List).take(3).join(', ');
      if (minerals.isNotEmpty) {
        nutritionData['Mineral:'] = minerals;
      }
    }

    final growth = analysis['growth_requirements'] ?? {};
    habitatTitle.value = 'Habitat & Distribusi';
    habitatText.value =
        'Tanah: ${growth['soil_type'] ?? 'Subur dengan drainase baik'}\n'
        'pH: ${growth['ph_range'] ?? '6.0 - 7.0'}\n'
        'Suhu: ${growth['temperature_range_number'] ?? '20–30'}°C\n'
        'Cahaya: ${growth['lighting'] ?? 'Sinar matahari penuh'}\n'
        'Air: ${growth['watering'] ?? 'Penyiraman teratur'}';

    advantages.clear();
    final uses = analysis['uses'] ?? {};

    if (uses['culinary'] != null && uses['culinary'] != '') {
      advantages.add('Kuliner: ${uses['culinary']}');
    }
    if (uses['medicinal'] != null && uses['medicinal'] != '') {
      advantages.add('Medis: ${uses['medicinal']}');
    }
    if (uses['industrial'] != null && uses['industrial'] != '') {
      advantages.add('Industri: ${uses['industrial']}');
    }

    if (nutrition['health_benefits'] is List) {
      final benefits = nutrition['health_benefits'] as List;
      if (benefits.isNotEmpty) {
        advantages.add('Manfaat Kesehatan:');
        advantages.addAll(benefits.map((e) => '• $e').toList());
      }
    }

    disadvantages.clear();
    final additional = analysis['additional_info'] ?? {};

    if (additional['risks'] != null && additional['risks'] != '') {
      disadvantages.add('Risiko: ${additional['risks']}');
    }
    if (additional['toxic_parts'] != null && additional['toxic_parts'] != '' && additional['toxic_parts'] != 'Tidak ada') {
      disadvantages.add('Bagian Beracun: ${additional['toxic_parts']}');
    }

    if (nutrition['dietary_notes'] is List) {
      final notes = (nutrition['dietary_notes'] as List).where((e) => e != null && e != '').toList();
      if (notes.isNotEmpty) {
        disadvantages.add('Catatan Diet: ${notes.join(', ')}');
      }
    }

    if (disadvantages.isEmpty) {
      disadvantages.add('Tidak ada risiko khusus yang teridentifikasi');
    }

    cultivation.clear();
    final care = analysis['care_instructions'] ?? {};

    if (care['watering'] != null && care['watering'] != '') {
      cultivation.add('Penyiraman: ${care['watering']}');
    }
    if (care['fertilization'] != null && care['fertilization'] != '') {
      cultivation.add('Pemupukan: ${care['fertilization']}');
    }
    if (care['other_maintenance'] != null && care['other_maintenance'] != '') {
      cultivation.add('Perawatan Lain: ${care['other_maintenance']}');
    }

    funFact.value = additional['native_habitat'] ?? 
        'Tanaman ini memiliki keunikan tersendiri dalam ekosistem.';
  }

  void saveToJournal() {
    Get.snackbar(
      'Tersimpan',
      'Data berhasil disimpan ke jurnal',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}