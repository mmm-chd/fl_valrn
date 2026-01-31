// lib/controllers/market_controller.dart

import 'package:fl_valrn/formatter/currency_formatter.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:fl_valrn/services/market_service.dart';
import 'package:fl_valrn/services/whatsapp_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  final searchController = TextEditingController();
  final chatController = TextEditingController();

  var isLoading = true.obs;
  var isLoadingCategories = true.obs;
  var isSendingMessage = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var productCard = <ProductItem>[].obs;
  var filteredProducts = <ProductItem>[].obs;

  final currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);

    fetchProducts();
  }

  @override
  void onClose() {
    searchController.dispose();
    chatController.dispose();
    super.onClose();
  }

  /// Search handler
  void _onSearchChanged() {
    final query = searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      // Tampilkan semua produk aktif
      filteredProducts.assignAll(
        productCard.where((p) => p.status == 'active').toList(),
      );
    } else {
      // Filter berdasarkan query search
      filteredProducts.assignAll(
        productCard.where((product) {
          final titleMatch = product.title.toLowerCase().contains(query);
          final descMatch = product.desc.toLowerCase().contains(query);
          final isActive = product.status == 'active';

          return (titleMatch || descMatch) && isActive;
        }).toList(),
      );
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      print('🔄 Starting fetchProducts...');

      final result = await MarketService.getProducts();

      print('✅ Received ${result.length} products');

      final activeProducts = result.where((p) => p.status == 'active').toList();

      print('✅ Active products: ${activeProducts.length}');

      productCard.assignAll(result);
      filteredProducts.assignAll(activeProducts);

      print('✅ Products assigned to controller');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();

      print('❌ ERROR FETCH PRODUCT: $e');

      Get.snackbar(
        'Error',
        'Gagal mengambil produk: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh products
  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  /// Mengirim pesan ke WhatsApp penjual
  Future<void> sendWhatsAppMessage(ProductItem product) async {
    try {
      final phoneNumber = product.user?.number ?? '';

      print('📱 Phone number from product.user: $phoneNumber');

      if (phoneNumber.isEmpty) {
        Get.snackbar(
          'Error',
          'Nomor telepon penjual tidak tersedia',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        return;
      }

      if (!WhatsAppService.isValidIndonesianPhone(phoneNumber)) {
        Get.snackbar(
          'Error',
          'Nomor telepon penjual tidak valid',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        return;
      }

      isSendingMessage.value = true;

      final formattedPrice = formatPrice(product.price);

      final success = await WhatsAppService.sendProductMessage(
        phoneNumber: phoneNumber,
        productName: product.title,
        price: formattedPrice,
        customMessage: chatController.text.trim().isNotEmpty
            ? chatController.text.trim()
            : null,
      );

      if (success) {
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
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('❌ ERROR SEND WHATSAPP: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } finally {
      isSendingMessage.value = false;
    }
  }

  String formatPrice(dynamic price) {
    try {
      print('🔄 Formatting price: $price (type: ${price.runtimeType})');
      final formatted = CurrencyFormatter.formatToRupiah(price);
      print('✅ Formatted price: $formatted');
      return formatted;
    } catch (e) {
      print('❌ Error formatting price: $e');
      return 'Rp 0';
    }
  }

  Future<void> sendCustomWhatsAppMessage({
    required ProductItem product,
    String? customMessage,
    int? quantity,
  }) async {
    try {
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

      final formattedPrice = formatPrice(product.price);

      final message = WhatsAppService.createCustomTemplate(
        productName: product.title,
        price: formattedPrice,
        quantity: quantity,
        additionalInfo: customMessage,
      );

      final success = await WhatsAppService.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
      );

      if (success) {
        Get.snackbar(
          'Berhasil',
          'Membuka WhatsApp...',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('❌ ERROR SEND CUSTOM WHATSAPP: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSendingMessage.value = false;
    }
  }

  Future<void> quickChatWhatsApp(ProductItem product) async {
    try {
      final phoneNumber = product.user?.number ?? '';

      if (phoneNumber.isEmpty) {
        Get.snackbar(
          'Error',
          'Nomor telepon penjual tidak tersedia',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final formattedPrice = formatPrice(product.price);

      final success = await WhatsAppService.sendProductMessage(
        phoneNumber: phoneNumber,
        productName: product.title,
        price: formattedPrice,
      );

      if (!success) {
        Get.snackbar(
          'Error',
          'Gagal membuka WhatsApp',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('❌ ERROR QUICK CHAT: $e');
    }
  }
}
