import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Format angka atau string menjadi format Rupiah
  /// Input bisa berupa int, double, atau String
  static String formatToRupiah(dynamic value) {
    try {
      // Jika null, return 0
      if (value == null) {
        return 'Rp 0';
      }

      // Konversi ke double
      double amount;
      
      if (value is String) {
        // Hapus karakter non-digit kecuali titik
        String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
        amount = double.tryParse(cleanValue) ?? 0.0;
      } else if (value is int) {
        amount = value.toDouble();
      } else if (value is double) {
        amount = value;
      } else {
        return 'Rp 0';
      }

      // Format menggunakan NumberFormat
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0, // Tidak menampilkan desimal untuk Rupiah
      );

      return formatter.format(amount);
    } catch (e) {
      print('Error formatting currency: $e');
      return 'Rp 0';
    }
  }

  /// Format harga dari string dengan handling khusus untuk data dari API
  static String formatFromApiPrice(String? price) {
    if (price == null || price.isEmpty) {
      return 'Rp 0';
    }
    
    try {
      // API mengembalikan harga dalam format "1200000.00"
      final cleanPrice = price.replaceAll('.00', '');
      final amount = double.parse(cleanPrice);
      
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      
      return formatter.format(amount);
    } catch (e) {
      print('Error formatting API price: $e, value: $price');
      return 'Rp 0';
    }
  }

  /// Parse Rupiah string kembali ke angka
  static double parseRupiah(String rupiahString) {
    try {
      String cleanValue = rupiahString
          .replaceAll('Rp', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .trim();
      
      return double.tryParse(cleanValue) ?? 0.0;
    } catch (e) {
      print('Error parsing Rupiah: $e');
      return 0.0;
    }
  }
}