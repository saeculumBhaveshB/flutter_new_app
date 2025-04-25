import 'package:intl/intl.dart';

class HelperFunctions {

  String formatCompactIndian(num number) {
  final formatted = NumberFormat.compact(locale: 'en_IN').format(number);
  return formatted
      .replaceAll('K', ' Thousand')
      .replaceAll('L', ' Lakh')
      .replaceAll('Cr', ' Crore');
  }
  
}

