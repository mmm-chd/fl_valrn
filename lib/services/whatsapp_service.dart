import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  /// Mengirim pesan ke WhatsApp
  ///
  /// [phoneNumber] - Nomor telepon (contoh: 081234567890 atau 6281234567890)
  /// [message] - Pesan yang akan dikirim
  ///
  /// Returns: true jika berhasil, false jika gagal
  static Future<bool> sendMessage({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      // Bersihkan nomor telepon dari karakter non-digit
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

      // Pastikan nomor dimulai dengan kode negara Indonesia (62)
      if (!cleanPhone.startsWith('62')) {
        if (cleanPhone.startsWith('0')) {
          // Ganti 0 di depan dengan 62
          cleanPhone = '62${cleanPhone.substring(1)}';
        } else {
          // Tambahkan 62 jika tidak ada kode negara
          cleanPhone = '62$cleanPhone';
        }
      }

      // Encode pesan untuk URL
      final encodedMessage = Uri.encodeComponent(message);

      // Gunakan whatsapp:// scheme (lebih reliable)
      final whatsappUrl = Uri.parse(
        'whatsapp://send?phone=$cleanPhone&text=$encodedMessage',
      );

      // Launch WhatsApp
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);

      return true;
    } catch (e) {
      // Fallback ke wa.me jika whatsapp:// gagal
      try {
        String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

        if (!cleanPhone.startsWith('62')) {
          if (cleanPhone.startsWith('0')) {
            cleanPhone = '62${cleanPhone.substring(1)}';
          } else {
            cleanPhone = '62$cleanPhone';
          }
        }

        final encodedMessage = Uri.encodeComponent(message);
        final waUrl = Uri.parse(
          'https://wa.me/$cleanPhone?text=$encodedMessage',
        );

        await launchUrl(waUrl, mode: LaunchMode.externalApplication);
        return true;
      } catch (e2) {
        print('Error membuka WhatsApp: $e2');
        return false;
      }
    }
  }

  /// Mengirim pesan produk ke WhatsApp dengan template
  ///
  /// [phoneNumber] - Nomor telepon tujuan
  /// [productName] - Nama produk
  /// [price] - Harga produk (format: Rp 100.000)
  /// [customMessage] - Pesan custom (opsional)
  static Future<bool> sendProductMessage({
    required String phoneNumber,
    required String productName,
    required String price,
    String? customMessage,
  }) async {
    final message =
        customMessage ??
        _createProductTemplate(productName: productName, price: price);

    return await sendMessage(phoneNumber: phoneNumber, message: message);
  }

  /// Membuat template pesan untuk produk
  static String _createProductTemplate({
    required String productName,
    required String price,
  }) {
    return 'Halo, saya tertarik dengan produk:\n\n'
        '📦 *$productName*\n'
        '💰 $price\n\n'
        'Apakah produk ini masih tersedia?';
  }

  /// Membuat template pesan custom
  ///
  /// [productName] - Nama produk
  /// [price] - Harga produk
  /// [quantity] - Jumlah produk (opsional)
  /// [additionalInfo] - Info tambahan (opsional)
  static String createCustomTemplate({
    required String productName,
    required String price,
    int? quantity,
    String? additionalInfo,
  }) {
    String message =
        'Halo, saya tertarik dengan produk:\n\n'
        '📦 *$productName*\n'
        '💰 $price';

    if (quantity != null) {
      message += '\n🔢 Jumlah: $quantity';
    }

    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      message += '\n\n$additionalInfo';
    }

    message += '\n\nApakah produk ini masih tersedia?';

    return message;
  }

  /// Mengirim pesan order/pesanan
  ///
  /// [phoneNumber] - Nomor telepon tujuan
  /// [items] - List item yang dipesan (contoh: ["Produk A x2", "Produk B x1"])
  /// [totalPrice] - Total harga
  /// [customerName] - Nama customer (opsional)
  static Future<bool> sendOrderMessage({
    required String phoneNumber,
    required List<String> items,
    required String totalPrice,
    String? customerName,
  }) async {
    String message = 'Halo, saya ingin memesan:\n\n';

    if (customerName != null && customerName.isNotEmpty) {
      message += '👤 Nama: *$customerName*\n\n';
    }

    message += '📋 *Pesanan:*\n';
    for (int i = 0; i < items.length; i++) {
      message += '${i + 1}. ${items[i]}\n';
    }

    message += '\n💰 Total: *$totalPrice*\n\n';
    message += 'Mohon konfirmasi ketersediaan produk. Terima kasih!';

    return await sendMessage(phoneNumber: phoneNumber, message: message);
  }

  /// Validasi nomor telepon Indonesia
  ///
  /// Returns: true jika nomor valid
  static bool isValidIndonesianPhone(String phoneNumber) {
    String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Cek panjang nomor (10-13 digit untuk Indonesia)
    if (cleanPhone.length < 10 || cleanPhone.length > 13) {
      return false;
    }

    // Cek awalan nomor
    if (cleanPhone.startsWith('62')) {
      // Format internasional: 62812xxx
      return cleanPhone.length >= 11 && cleanPhone.length <= 14;
    } else if (cleanPhone.startsWith('0')) {
      // Format lokal: 0812xxx
      return cleanPhone.length >= 10 && cleanPhone.length <= 13;
    } else if (cleanPhone.startsWith('8')) {
      // Format tanpa 0: 812xxx
      return cleanPhone.length >= 9 && cleanPhone.length <= 12;
    }

    return false;
  }

  /// Format nomor telepon ke format Indonesia yang benar
  ///
  /// Returns: Nomor dengan format 62xxx atau null jika tidak valid
  static String? formatPhoneNumber(String phoneNumber) {
    if (!isValidIndonesianPhone(phoneNumber)) {
      return null;
    }

    String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (!cleanPhone.startsWith('62')) {
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62${cleanPhone.substring(1)}';
      } else {
        cleanPhone = '62$cleanPhone';
      }
    }

    return cleanPhone;
  }
}
