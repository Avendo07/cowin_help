import 'package:intl/intl.dart';

class DateTimeUtility{
  static String formatDate(DateTime dateTime){
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String date = dateFormat.format(dateTime);
    print("Dt" + date);
    return date;
  }
}