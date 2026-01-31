import 'package:fl_valrn/dummy_data/dummyTrending.dart';
import 'package:fl_valrn/formatter/currency_formatter.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/model/trending_model.dart';
import 'package:fl_valrn/services/market_service.dart';
import 'package:fl_valrn/services/whatsapp_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  final searchController = TextEditingController();
  final chatController = TextEditingController();

  var isLoading = true.obs;
  var isSendingMessage = false.obs;
  var trendingCard = <TrendingItem>[].obs;
  var productCard = <ProductItem>[].obs;

  final currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTrendings();
    fetchProducts();
  }

  @override
  void onClose() {
    searchController.dispose();
    chatController.dispose();
    super.onClose();
  }

  void fetchTrendings() async {
    await Future.delayed(Duration(seconds: 2));
    trendingCard.value = dummyTrending;
    isLoading.value = false;
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      final result = await MarketService.getProducts();
      productCard.assignAll(result);
    } catch (e) {
      print('ERROR FETCH PRODUCT: $e');
      Get.snackbar(
        'Error',
        'Gagal mengambil produk',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Mengirim pesan ke WhatsApp penjual
  Future<void> sendWhatsAppMessage(ProductItem product) async {
    try {
      // Validasi input
      if (chatController.text.trim().isEmpty) {
        Get.snackbar(
          'Peringatan',
          'Silakan masukkan pesan terlebih dahulu',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Validasi nomor telepon penjual
      // Menggunakan field 'number' dari User model
      final phoneNumber = product.user?.number ?? '';

      if (phoneNumber.isEmpty) {
        Get.snackbar(
          'Error',
          'Nomor telepon penjual tidak tersedia',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isSendingMessage.value = true;

      // Buat pesan
      final formattedPrice = CurrencyFormatter.formatToRupiah(product.price);
      final message = WhatsAppService.createProductMessage(
        productName: product.title,
        price: formattedPrice,
        customMessage: chatController.text.trim(),
      );

      // Kirim ke WhatsApp
      final success = await WhatsAppService.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
      );

      if (success) {
        // Bersihkan text field setelah berhasil
        chatController.clear();

        Get.snackbar(
          'Berhasil',
          'Membuka WhatsApp...',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          'Gagal membuka WhatsApp. Pastikan WhatsApp terinstall.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('ERROR SEND WHATSAPP: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSendingMessage.value = false;
    }
  }

  /// Format harga untuk ditampilkan
  String formatPrice(dynamic price) {
    return CurrencyFormatter.formatToRupiah(price);
  }
}
