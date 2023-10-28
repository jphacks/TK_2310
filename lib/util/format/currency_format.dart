import 'package:intl/intl.dart';

final oCcy = NumberFormat('#,##0', 'en_JP');

String currencyFormat(int value) => '${oCcy.format(value)}円';
