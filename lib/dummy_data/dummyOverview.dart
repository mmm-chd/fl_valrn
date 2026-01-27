class DummyOverviewData {
  static Map<String, dynamic> getData() {
    return {
      'analysis': {
        'identification': {
          'common_name': 'Wortel',
          'scientific_name': 'Daucus carota',
          'short_description': 'Wortel adalah sayuran akar yang kaya akan beta-karoten dan vitamin A. Bagian yang dikonsumsi adalah akarnya yang umumnya berwarna oranye, meskipun ada varietas ungu, merah, kuning, dan putih.',
        },
        'health': {
          'status': 'diseased',
          'summary': 'Wortel adalah sayuran akar yang kaya akan beta-karoten dan vitamin A. Bagian yang dikonsumsi adalah akarnya yang umumnya berwarna oranye, meskipun ada varietas ungu, merah, kuning, dan putih. Kaya akan antioksidan.',
          'symptoms': [
            'Bercak kecil berwarna cokelat kehitaman pada daun',
            'Daun menguning lalu mengering',
          ],
          'diseases': [
            {
              'name': 'Bercak Daun (Leaf Blight)',
            }
          ],
          'pests': [
            'Kelembaban tinggi dan suhu yang lembab',
            'Infeksi jamur Alternaria dauci atau Cercospora carotae',
          ],
          'action_plan': {
            'short_term': [
              'Fotosintesis daun terhambat',
              'Kualitas tanaman menurun',
              'Hasil panen rendah',
              'Jaga jarak tanam agar tidak terlalu rapat',
            ],
          },
          'recommended_actions': [
            'Gunakan benih yang sehat',
            'Rotasi tanaman',
            'Jaga kebersihan kebun dan sanitasi',
            'Aplikasi fungisida bila perlu',
          ],
        },
        'nutritional_value': {
          'nutrients_per_100g': {
            'energy': '662 kkal',
            'carbohydrates': '91 gram',
            'protein': '9,6 gram',
            'fiber': '11,8 gram',
            'fat': '1,5 gram',
          },
          'vitamins': [
            'Vitamin A: 835 mcg',
            'Vitamin C: 2.023 mcg',
            'Folat: 19 mcg',
          ],
          'minerals': [
            'Kalium: 320 mg',
          ],
          'health_benefits': [
            'Meningkatkan kesehatan mata: Beta-karoten dalam wortel diubah menjadi vitamin A yang penting bagi penglihatan.',
            'Meningkatkan Sistem Imun: Wortel kaya akan antioksidan yang membantu memperkuat sistem kekebalan tubuh.',
            'Menjaga Kesehatan Kulit: Vitamin A dan antioksidan membantu menjaga kulit tetap sehat dan mencegah kerusakan.',
          ],
          'dietary_notes': [],
        },
        'growth_requirements': {
          'soil_type': 'tanah lempung berpasir',
          'ph_range': '6.0-7.0',
          'temperature_range_number': '15-21°C',
          'lighting': 'Membutuhkan sinar matahari penuh',
          'watering': 'Siram secara teratur, jaga kelembaban tanah',
        },
        'uses': {
          'culinary': 'Dapat direbus, digoreng, atau dimakan mentah dalam salad',
          'medicinal': 'Baik untuk kesehatan mata dan sistem imun',
          'industrial': '',
        },
        'care_instructions': {
          'watering': 'Siram secara teratur, jaga kelembaban tanah',
          'fertilization': 'Berikan pupuk NPK setiap 2-3 minggu',
          'other_maintenance': 'Persiapan lahan: Gemburkan tanah dan beri pupuk organik',
        },
        'additional_info': {
          'native_habitat': 'Wortel pertama kali dibudidayakan di Afghanistan sekitar abad ke-10 dan awalnya berwarna ungu atau putih, bukan oranye!',
          'risks': 'Karotenemia: Konsumsi berlebihan dapat menyebabkan kulit kekuningan. Alergi: Beberapa orang mungkin mengalami reaksi alergi. Masalah Pencernaan: Terlalu banyak wortel dapat menyebabkan kembung.',
          'toxic_parts': '',
        },
      },
    };
  }
}