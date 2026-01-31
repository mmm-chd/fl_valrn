import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  /// Mengirim pesan ke WhatsApp
  /// [phoneNumber] - Nomor telepon dengan kode negara (contoh: 6281234567890)
  /// [message] - Pesan yang akan dikirim
  static Future<bool> sendMessage({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      // Bersihkan nomor telepon dari karakter non-digit
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

      // Pastikan nomor dimulai dengan kode negara
      if (!cleanPhone.startsWith('62')) {
        // Jika dimulai dengan 0, ganti dengan 62
        if (cleanPhone.startsWith('0')) {
          cleanPhone = '62${cleanPhone.substring(1)}';
        } else {
          // Jika tidak ada kode negara, tambahkan 62
          cleanPhone = '62$cleanPhone';
        }
      }

      // Encode pesan untuk URL
      final encodedMessage = Uri.encodeComponent(message);

      // Buat URL WhatsApp
      final whatsappUrl = 'https://wa.me/$cleanPhone?text=$encodedMessage';
      final uri = Uri.parse(whatsappUrl);

      // Cek apakah bisa membuka URL
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      } else {
        throw Exception('Tidak dapat membuka WhatsApp');
      }
    } catch (e) {
      print('Error membuka WhatsApp: $e');
      return false;
    }
  }

  /// Membuat template pesan untuk produk
  static String createProductMessage({
    required String productName,
    required String price,
    String? customMessage,
  }) {
    if (customMessage != null && customMessage.isNotEmpty) {
      return customMessage;
    }

    return 'Halo, saya tertarik dengan produk:\n\n'
        '📦 *$productName*\n'
        '💰 $price\n\n'
        'Apakah produk ini masih tersedia?';
  }
}
