import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Format angka menjadi format Rupiah (Rp 1.200.000)
  static String formatToRupiah(dynamic value) {
    if (value == null) return 'Rp 0';
    
    double amount;
    if (value is String) {
      amount = double.tryParse(value) ?? 0;
    } else if (value is int) {
      amount = value.toDouble();
    } else if (value is double) {
      amount = value;
    } else {
      return 'Rp 0';
    }

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  /// Format angka tanpa simbol Rupiah (1.200.000)
  static String formatNumber(dynamic value) {
    if (value == null) return '0';
    
    double amount;
    if (value is String) {
      amount = double.tryParse(value) ?? 0;
    } else if (value is int) {
      amount = value.toDouble();
    } else if (value is double) {
      amount = value;
    } else {
      return '0';
    }

    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(amount);
  }
}